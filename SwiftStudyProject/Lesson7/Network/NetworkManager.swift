//
//  NetworkManager.swift
//  SwiftStudyProject
//
//  Created by Rodion Blyshchak on 18.02.2026.
//

import UIKit
import Combine

struct ResponseWrapper<T: Decodable>: Decodable {
	let record: T?
//	let metadata: Metadata?
}

//struct Metadata: Decodable {
//	let id: String?
//	let createdAt: String?
//}

protocol NetworkService {
	func request<T: Decodable>(_ endpoint: Endpoint, parameters: Encodable?) -> AnyPublisher<T, APIError>
}

class NetworkManager: NetworkService {
	private let baseURL: String
	
	init(environment: APIEnvironment = .development) {
		self.baseURL = environment.baseURL
	}
	
	func request<T: Decodable>(_ endpoint: Endpoint, parameters: Encodable? = nil) -> AnyPublisher<T, APIError> {
		guard let url = URL(string: baseURL + endpoint.path) else {
			return Fail(error: APIError.invalidURL).eraseToAnyPublisher()
		}
		var urlRequest = URLRequest(url: url)
		
		if let parameters = parameters {
			urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
			do {
				let jsonData = try JSONEncoder().encode(parameters)
				urlRequest.httpBody = jsonData
			} catch {
				return Fail(error: APIError.requestFailed("Encoding parameters failed.")).eraseToAnyPublisher()
			}
		}
		return URLSession.shared.dataTaskPublisher(for: urlRequest)
			.tryMap { (data, response) -> Data in
				if let httpResponse = response as? HTTPURLResponse,
				   (200..<300).contains(httpResponse.statusCode) {
					return data
				} else {
					let statusCode = (response as? HTTPURLResponse)?.statusCode ?? -1
					throw APIError.requestFailed("Request failed with status code: \(statusCode)")
				}
			}
			.decode(type: ResponseWrapper<T>.self, decoder: JSONDecoder())
			.tryMap { wrapper in
				guard let resultData = wrapper.record else {
					throw APIError.requestFailed("Missing status.")
				}
				return resultData
			}
			.mapError { error -> APIError in
				if error is DecodingError {
					return APIError.decodingFailed
				} else if let apiError = error as? APIError {
					return apiError
				} else {
					return APIError.requestFailed("An unknown error occurred.")
				}
			}
			.eraseToAnyPublisher()
	}
}
