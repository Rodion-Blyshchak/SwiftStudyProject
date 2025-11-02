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
		let randomNumberKilometers = Int.random(in: 10...300) // У ТЗ сказано Double.random(in: 10...300)) но у drive(kilometers:) передаємо саме Int
		
		if let currentVehicle = vehicle {
			currentVehicle.drive(kilometers: randomNumberKilometers)
		} else {
			print("\(name) тупцює ніжками, бо транспорту нема")
		}
	}
}
