//
//  Driver.swift
//  SwiftStudyProject
//
//  Created by Rodion Blyshchak on 28.10.2025.
//

struct Driver {
	var name: String
	var age: Int
	var vehicle: VehicleProtocol?
	var experience: Int
	
	func driveRandomly() {
		let randomNumberKilometers = Int.random(in: 10...300)
		
		guard let vehicle else {
			print("\(name) тупцює ніжками, бо транспорту нема")
			return
		}
		
		vehicle.drive(kilometers: randomNumberKilometers)
	}
}
