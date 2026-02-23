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
	
	func fetchData() -> [CarModel]? {
		guard let baseCarModelsJSON = Bundle.main.url(forResource: "baseCarModelsJSON", withExtension: "json") else { return nil }
		
		do {
			let data = try Data(contentsOf: baseCarModelsJSON)
			let resultData = try JSONDecoder().decode(CarResponseModel.self, from: data)
			print(String(data: data, encoding: .utf8)!)
			return resultData.record
		} catch {
			print(error.localizedDescription)
			return nil
		}
	}
}
