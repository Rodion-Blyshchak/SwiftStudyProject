
protocol VehicleProtocol {
	var brand: String { get }
	var fuelType: FuelType { get }
	var numberWheels: Int { get }
	var mileage: Int { get }
	
	func drive (kilometers: Int)
}
