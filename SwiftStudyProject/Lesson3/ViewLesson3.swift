/*
 Теорія:
  • Struct vs Class — у чому різниця, коли що краще використовувати
  • Ініціалізатори (init), властивості, методи
  • Наслідування класів, ключові слова super і override
  • Protocol: що це таке, навіщо потрібен, як змушує дотримуватись правил
  • Enum: raw values, associated values
  • Extension: як “дописати” нову поведінку до вже існуючого типу

 Практика:
  • Створити гілку Lesson3 у GitHub
  • У проекті створити файл Lesson3.swift і виконати наступне
  1. Створити enum FuelType, який має три значення: petrol, diesel, electric
  • Додати метод або var description: String, що повертає текстовий опис типу палива
  2. Створити протокол Vehicle, який описує загальні властивості та поведінку транспортного засобу:
  • бренд
  • тип пального
  • кількість колес
  • пробіг
  • функція "їхати" (з параметром кілометрів)
  3. Створити клас Car, який реалізує протокол Vehicle
  • Ініціалізатор, який приймає brand і fuelType
  • Реалізація методу drive(kilometers:):
  • додає кілометри до mileage
  • друкує повідомлення залежно від типу палива:
  • якщо petrol — "турбінка дує (brand) чимчикує"
  • якщо diesel — "помалу-потрохи але їдемо"
  • якщо electric — "вжух, тихо і економно"
  4. Створити клас Motorcycle, який також реалізує протокол Vehicle
  • Ініціалізатор аналогічний до Car
  • Реалізація методу drive(kilometers:) - так само, але друкувати "пролітаю між заторів"
  5. Створити масив із 10 транспортних засобів (частина — автомобілі, частина — мотоцикли)
  • Для кожного викликати drive(kilometers:) від 1 до 5 разів (рандомно) з випадковим числом (0–500 км)
  • Після кожної поїздки друкувати пробіг і повідомлення
  6. Підрахувати і надрукувати статистику:\
  • Кількість транспортних засобів
  • Кількість автомобілів і мотоциклів
  • Кількість кожного типу палива
  •  • Середній пробіг усіх транспортних засобів
*/


class ViewLesson3 {
	static let shared = ViewLesson3()
	
	let vehiclesList: [VehicleProtocol] = [
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

	func vehicleSimulatorAndStatics() {
		// VehicleSimulator
		let randomNumberVehicleSimulatorCalls = Int.random(in: 1...5)
		var newVehiclesList: [VehicleProtocol] = []
		
		for _ in 1...randomNumberVehicleSimulatorCalls {
			for itemVehicle in vehiclesList {
				itemVehicle.drive(kilometers: Int.random(in: 0...500))
				newVehiclesList.append(itemVehicle)
			}
		}
		
		// Statics
		print("Загальна кількість транспортних засобів - \(newVehiclesList.count)")
		let arrayCar: [VehicleProtocol] = newVehiclesList.filter {$0 is Car}
		let arrayMotorcycle: [VehicleProtocol] = newVehiclesList.filter {$0 is Motorcycle}
		print("Кількість автомобілів - \(arrayCar.count)")
		print("Кількість мотоциклів - \(arrayMotorcycle.count)")

		print("Вжух-вжух на бензині - \(newVehiclesList.filter{$0.fuelType == .petrol}.count)шт")
		print("Вжух-вжух на дизель - \(newVehiclesList.filter{$0.fuelType == .diesel}.count)шт")
		print("Вжух-вжух на електриції - \(newVehiclesList.filter{$0.fuelType == .electric}.count)шт")
		
		var vehiclesListMileage: [Int] = []
		
		for itemVehicle in newVehiclesList {
			vehiclesListMileage.append(itemVehicle.mileage)
		}
		
		var averageVehicleMileage = 0
		
		for itemMileage in vehiclesListMileage {
			averageVehicleMileage += itemMileage
		}
		
		averageVehicleMileage = averageVehicleMileage / vehiclesListMileage.count
		
		print("Середній пробіг - \(averageVehicleMileage)км")
		
	}
}
