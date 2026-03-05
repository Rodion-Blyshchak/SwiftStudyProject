//
//  ResponseViewModel.swift
//  SwiftStudyProject
//
//  Created by Rodion Blyshchak on 05.03.2026.
//

import Foundation
import Combine

class ResponseViewModel: ObservableObject {

	@Published var cars: [CarModel] = []
	private let networkService: NetworkService
	private var cancellables: Set<AnyCancellable> = []

	init(networkService: NetworkService = NetworkManager()) {
		self.networkService = networkService
	}

	func signUp(onCompletion: @escaping (Bool) -> ())  {
		let response: AnyPublisher<[CarModel], APIError> = networkService.request(.getCars, parameters: nil)
		response
			.sink { completion in
				switch completion {
					case .finished:
						break
					case .failure(let error):
						print("Error: \(error)")
						onCompletion(false)
				}
			} receiveValue: { downloadedCars in
				self.cars = downloadedCars
		}
			.store(in: &cancellables)
	}
}
