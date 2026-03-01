//
//  NetworkManager.swift
//  SwiftStudyProject
//
//  Created by Rodion Blyshchak on 18.02.2026.
//

import UIKit

class NetworkManager {
	static let shared = NetworkManager()
	private init() {}
	
	//	https://api.jsonbin.io/v3/b/698f838cae596e708f28a522
	
	func fetchData(completion: @escaping ([CarModel]) -> Void) {
		guard let url = URL(string: "https://api.jsonbin.io/v3/b/698f838cae596e708f28a522") else { return }
		
		URLSession.shared.dataTask(with: url) { data, response, error in
			guard let data = data, error == nil else { return }
			print(String(data: data, encoding: .utf8)!)
			
			do {
				let resultData = try JSONDecoder().decode(CarResponseModel.self, from: data)
				DispatchQueue.main.async {
					completion(resultData.record)
				}
			} catch {
				print(error.localizedDescription)
				completion([])
			}
		}.resume()
	}
	
//	func fetchData() -> [CarModel] {
//		guard let baseCarModelsJSON = Bundle.main.url(forResource: "baseCarModelsJSON", withExtension: "json") else { return [] }
//		
//		do {
//			let data = try Data(contentsOf: baseCarModelsJSON)
//			let resultData = try JSONDecoder().decode(CarResponseModel.self, from: data)
////			print(String(data: data, encoding: .utf8)!)
//			return resultData.record
//		} catch {
//			print(error.localizedDescription)
//			return []
//		}
//	}
	
	func downloadImage(from url: URL, completion: @escaping (UIImage?) -> Void) {
		URLSession.shared.dataTask(with: url) { data, response, error in
			guard let data = data, error == nil else { return }
			DispatchQueue.main.async {
				completion(UIImage(data: data))
			}
		}.resume()
	}
}
