//
//  CarEntity+CoreDataProperties.swift
//  SwiftStudyProject
//
//  Created by Rodion Blyshchak on 07.02.2026.
//
//

public import Foundation
public import CoreData


public typealias CarEntityCoreDataPropertiesSet = NSSet

@objc(CarEntity)
public class CarEntity: NSManagedObject {

}

extension CarEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CarEntity> {
        return NSFetchRequest<CarEntity>(entityName: "CarEntity")
    }

    @NSManaged public var acceleration: Float
    @NSManaged public var carDescription: String?
	@NSManaged public var id: Int64
    @NSManaged public var image: String?
	@NSManaged public var imageData: Data?
    @NSManaged public var maxSpead: Int16
    @NSManaged public var name: String?
    @NSManaged public var team: String?
    @NSManaged public var weight: Int16
    @NSManaged public var isInFavorite: Bool

}

extension CarEntity : Identifiable {

}
