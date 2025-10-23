
class Car: VehicleProtocol {
	var brand: String
	var fuelType: FuelType
	var numberWheels = 4
	var mileage: Int = Int.random(in: 0...300)
	
	init(brand: String, fuelType: FuelType) {
		self.brand = brand
		self.fuelType = fuelType
	}
	
	func drive(kilometers: Int) {
		mileage += kilometers
		
		print("Пробіг \(brand) - \(mileage)км")
		
		if fuelType == .petrol {
			print("турбінка дує \(brand) чимчикує")
		} else if fuelType == .diesel {
			print("помалу-потрохи але їдемо")
		} else if fuelType == .electric {
			print("вжух, тихо і економно")
		}
	}
}

