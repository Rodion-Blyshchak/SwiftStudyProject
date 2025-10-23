

class Motorcycle: VehicleProtocol {
	var brand: String
	var fuelType: FuelType
	var numberWheels = 2
		var mileage: Int = Int.random(in: 0...300)
	
	init(brand: String, fuelType: FuelType) {
		self.brand = brand
		self.fuelType = fuelType
	}
	
	func drive(kilometers: Int) {
		mileage += kilometers
		
		print("Пробіг \(brand) - \(mileage)км")
		
		if fuelType == .petrol {
			print("вжух, голосно пролітаю між заторів")
		} else if fuelType == .electric {
			print("вжух, тихеньк пролітаю між заторів")
		}
	}
}
