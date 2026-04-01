//
//  CoreDataManager.swift
//  SwiftStudyProject
//
//  Created by Rodion Blyshchak on 07.02.2026.
//

import UIKit
import CoreData

final class CoreDataManager {
	static let shared = CoreDataManager()
	private init() {}
	
	private var appDelegate: AppDelegate {
		UIApplication.shared.delegate as! AppDelegate
	}
	
	private var context: NSManagedObjectContext {
		appDelegate.persistentContainer.viewContext
	}

	func saveCar(model: CarModel) {
		let fetchRequest: NSFetchRequest<CarEntity> = CarEntity.fetchRequest()
		fetchRequest.predicate = NSPredicate(format: "id == %d", model.id)
		
		do {
			let results = try context.fetch(fetchRequest)	
			let entity: CarEntity
			
			if let existingCar = results.first {
				entity = existingCar
			} else {
				entity = CarEntity(context: context)
				entity.id = Int64(model.id)
			}
			
			entity.name = model.name
			entity.image = model.image
			entity.imageData = model.imageData
			entity.team = model.team
			entity.carDescription = model.description
			entity.maxSpead = Int16(model.maxSpeed)
			entity.acceleration = model.acceleration
			entity.weight = Int16(model.weight)
			entity.isInFavorite = model.isInFavorite
			entity.latitude = model.location?.latitude ?? 0
			entity.longitude = model.location?.longitude ?? 0
			
			appDelegate.saveContext()
		} catch {
			print("Failed to fetch or save car: \(error)")
		}
	}
	
	func saveImageData(id: Int, data: Data) {
		let fetchRequest: NSFetchRequest<CarEntity> = CarEntity.fetchRequest()
		fetchRequest.predicate = NSPredicate(format: "id == %d", id)
		
		do {
			let results = try context.fetch(fetchRequest)
			if let car = results.first {
				car.imageData = data
				appDelegate.saveContext()
			}
		} catch {
			print("Failed to save image data: \(error)")
		}
	}
	
	func deleteCar(id: Int) {
		let fetchRequest: NSFetchRequest<CarEntity> = CarEntity.fetchRequest()
		fetchRequest.predicate = NSPredicate(format: "id == %d", id)
		
		do {
			let results = try context.fetch(fetchRequest)
			if let carDelete = results.first {
				context.delete(carDelete)
			}
			try context.save()
		} catch {
			print("Failed to delete car: \(error)")
		}
	}
	
	func fetchAllCars() -> [CarModel] {
		let fetchRequest: NSFetchRequest<CarEntity> = CarEntity.fetchRequest()
		
		do {
			let entities = try context.fetch(fetchRequest)
			return entities.compactMap{ (entity: CarEntity) -> CarModel? in
//				guard let id = entity.id else { return nil}
				return CarModel(
					id: Int(entity.id),
					image: entity.image,
					imageData: entity.imageData,
					name: entity.name ?? "",
					team: entity.team ?? "",
//					description: entity.carDescription,
					maxSpeed: Int(entity.maxSpead),
					acceleration: entity.acceleration,
					weight: Int(entity.weight),
					isInFavorite: entity.isInFavorite,
					location: Location(latitude: entity.latitude, longitude: entity.longitude)
				)
			}
		} catch {
			print("Failed to fetch cars: \(error)")
			return []
		}
	}
}
