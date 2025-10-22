

class Motorcycle: VehicleProtocol {
	var brand: String
	var fuelType: FuelType
	var numberWheels = 2
	var mileage = 0
	
	init(brand: String, fuelType: FuelType) {
		self.brand = brand
		self.fuelType = fuelType
	}
	
	func drive(kilometers: Int) {
		let sum = mileage + kilometers
		
		if fuelType == .petrol {
			print("вжух, голосно пролітаю між заторів")
		} else if fuelType == .electric {
			print("вжух, тихеньк пролітаю між заторів")
		}
	}
}
