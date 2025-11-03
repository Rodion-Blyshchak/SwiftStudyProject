/*4й тиждень

Ну що ж, цього тижня закругляємось з "базою" і будемо переходити до більш реальних задач, які можуть спіткати тебе на роботі, а ось завдання на наступний тиждень:

Теорія:
 • Методи сортування із книги "Грокаєм алгоритми", що таке "складність"
 • Optional: що це, навіщо потрібен, як безпечно розпаковувати (if let, guard let, ??, !)
 • Closures: що це таке, як виглядає синтаксис, передача замикань у функції
 • Модифікатори доступу: private, fileprivate, internal, public, open — коли який використовувати
 • lazy properties та computed properties
 • Параметр inout

Практика:
 • Створити гілку Lesson4 у GitHub
 • У проекті створити файл Lesson4.swift
 • Для цього завдання також використаємо протоколи/класи із попереднього завдання

 1. Уявімо, що ми розвиваємо автопарк майбутнього.
Створи структуру Driver, у якій є:
 • name: String
 • age: Int
 • vehicle: Vehicle? — опціональний, бо не кожен має транспорт
 • experience: Int — стаж у роках
 2. Створи масив із 10–15 водіїв (кілька без транспорту, кілька з авто і мотоциклами).
 3. Завдання:
 • Відфільтрувати всіх водіїв, у яких є транспорт, і надрукувати їх у консоль
 • Відсортувати водіїв за стажем (experience), від найдосвідченішого до найнедосвідченнішого і роздрукувати
 • Відсортувати за віком від наймолодщого до найстаршого і роздрукувати
 4. Створи функцію:
func assignVehicle(to driver: Driver, from availableVehicles: inout [Vehicle]) -> Driver
яка:
 • перевіряє, чи у водія вже є транспорт
 • якщо немає — бере перший доступний Vehicle з масиву,
призначає його водієві та видаляє з пулу доступних
 • повертає оновленого водія
 5. Використай цю функцію для призначення транспорту всім водіям, у яких vehicle == nil.
 • Наприкінці виведи оновлений список усіх водіїв і їх транспортів.
 • Якщо транспорту не вистачило — виведи скільки людей залишилось без нього.   ++++
 6. Додай до Driver метод driveRandomly(), який:
 • генерує випадкову кількість кілометрів (наприклад, Double.random(in: 10...300))
 • якщо є транспорт — викликає drive(kilometers:) у нього
 • якщо немає — друкує “(name) тупцює ніжками, бо транспорту нема”
 7. Використай forEach, щоб кожен водій “зробив поїздку”.
 8. Додай private до тих властивостей і методів, які не потрібно бачити зовні.
Наприклад, зроби mileage у транспортних засобах приватним,
а публічний геттер (computed property) mileageInfo, який друкує пробіг у читабельному форматі.

Задачка з зірочкою:
 ⁃ Зробити реалізацію алгоритмів сортування із книги але на Swift (наскільки памʼятаю, там вже є реалізації, але буде класно хоча б "переписати", щоб краще запамятати)
 ⁃ бульбашкою
 ⁃ quick sort
 ⁃ merge sort
*/

// print("\n") - відступ у терміналі

class ViewLesson4 {
	static let shared = ViewLesson4()
	
	private func assignVehicle(to driver: Driver, from availableVehicles: inout [VehicleProtocol]) -> Driver {
		guard driver.vehicle == nil, availableVehicles.count > 0 else {
			return driver
		}
		
		var updatedDriver = driver
	
		updatedDriver.vehicle = availableVehicles.first
		availableVehicles = Array(availableVehicles.dropFirst())

		return updatedDriver
	   }
	
	func start() {
		var vehiclesList: [VehicleProtocol] = [
			  Car(brand: "Toyota", fuelType: .petrol),
			  Car(brand: "BMW", fuelType: .diesel),
			  Car(brand: "Audi", fuelType: .electric),
			  Motorcycle(brand: "Honda", fuelType: .petrol),
			  Motorcycle(brand: "Yamaha", fuelType: .electric),
			  Car(brand: "Ford", fuelType: .petrol),
			  Car(brand: "Tesla", fuelType: .electric),
			  Motorcycle(brand: "Kawasaki", fuelType: .petrol),
			  Car(brand: "Mercedes", fuelType: .diesel),
			  Motorcycle(brand: "Ducati", fuelType: .petrol)
		]

		var arrayDrivers: [Driver] = [
			Driver(name: "Denys", age: 23, vehicle: nil, experience: 2),
			Driver(name: "Ihor", age: 30, vehicle: nil, experience: 8),
			Driver(name: "Andriy", age: 27, vehicle: nil, experience: 0),
			Driver(name: "Roman", age: 50, vehicle: nil, experience: 30),
			Driver(name: "Ira", age: 43, vehicle: vehiclesList[4], experience: 19),
			Driver(name: "Maksym", age: 20, vehicle: nil, experience: 1),
			Driver(name: "Serhii", age: 38, vehicle: vehiclesList[3], experience: 13),
			Driver(name: "Oleg", age: 27, vehicle: nil, experience: 4),
			Driver(name: "Svitlana", age: 46, vehicle: nil, experience: 26),
			Driver(name: "Yurii", age: 34, vehicle: nil, experience: 6),
			Driver(name: "Ilya", age: 23, vehicle: nil, experience: 1),
			Driver(name: "Slavik", age: 28, vehicle: nil, experience: 2),
			Driver(name: "Vadim", age: 48, vehicle: vehiclesList[6], experience: 23),
			Driver(name: "Ivan", age: 25, vehicle: nil, experience: 4),
			Driver(name: "Pasha", age: 22, vehicle: nil, experience: 3)
		]
		
		arrayDrivers.forEach {
			guard let vehicle = $0.vehicle else {return}
			print("\($0.name) та його \(vehicle.brand)")
		}
		
		let sortedArrayDrivesByExperience = arrayDrivers.sorted {$0.experience > $1.experience}
		let sortedArrayDrivesByAge = arrayDrivers.sorted {$0.age < $1.age}
		
		print("\n")
		sortedArrayDrivesByExperience.forEach {
			print("\($0.name) має \($0.experience) років досвіду")
		}
		
		print("\n")
		sortedArrayDrivesByAge.forEach {
			print("\($0.name) має \($0.age) років")
		}
		
		for index in arrayDrivers.indices {
			let currentDriver = arrayDrivers[index]
			let updatedDriver = assignVehicle(to: currentDriver, from: &vehiclesList)
			arrayDrivers[index] = updatedDriver
			
			let transportName = updatedDriver.vehicle?.brand ?? "ще не має("
			print("Водій: \(updatedDriver.name), транспорт: \(transportName)")
			
		}
		
		let numberUnitsWithoutTransport = arrayDrivers.filter{$0.vehicle == nil}.count
		print("ехх, не вистачило транспортних засобів для \(numberUnitsWithoutTransport) водіїв")
		
		print("\n")
		arrayDrivers.forEach {$0.driveRandomly()}
	}
}
