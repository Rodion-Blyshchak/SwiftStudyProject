
class Car: VehicleProtocol {
	var brand: String
	var fuelType: FuelType
	var numberWheels = 4
	var mileage = 0
	
	init(brand: String, fuelType: FuelType) {
		self.brand = brand
		self.fuelType = fuelType
	}
	
	func drive(kilometers: Int) {
		let sum = mileage + kilometers
		
		if fuelType == .petrol {
			print("турбінка дує \(brand) чимчикує")
		} else if fuelType == .diesel {
			print("помалу-потрохи але їдемо")
		} else if fuelType == .electric {
			print("вжух, тихо і економно")
		}
	}
}

