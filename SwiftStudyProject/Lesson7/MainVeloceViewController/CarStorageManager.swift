//
//  CarStorageManager.swift
//  SwiftStudyProject
//
//  Created by Rodion Blyshchak on 19.01.2026.
//

import UIKit

protocol CarStorageManagerDelegate {
	func didUpdateFavorites(list: [String])
}

class CarStorageManager {
	var listFavorite: [String] = []
	var delegate: CarStorageManagerDelegate?
	private let defaults = UserDefaults.standard
	private let favoritesKey = "favorite_cars_id_key"
	
	init() {
		loadFromDefaults()
	}
	
	func add(id: String) {
		if !listFavorite.contains(id) {
			listFavorite.append(id)
			syncData()
		}
	}
	
	func remove(id: String) {
		if let index = listFavorite.firstIndex(of: id) {
			listFavorite.remove(at: index)
			syncData()
		}
	}
	
	func isFavorite(id: String) -> Bool {
		return listFavorite.contains(id)
	}
	
	func syncData() {
		saveToDefaults()
		delegate?.didUpdateFavorites(list: listFavorite)
	}
	
	//MARK: - Func UserDefaults
	private func saveToDefaults() {
		defaults.set(listFavorite, forKey: favoritesKey)
	}
	
	private func loadFromDefaults() {
		listFavorite = defaults.stringArray(forKey: favoritesKey) ?? []
	}
	
}


//carStoreMan  буде тримати масив id ->
//1. Додати машину, має приймати id і оновити масив 
//2. Видалити машину
//3. UserDefaults
//4. приймає id та повертає чи знаходиться цей id у масиві
