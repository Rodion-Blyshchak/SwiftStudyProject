/*
 ⁃ Створити проєкт, у проєкті створити папку "Lesson1", додати будь-який файл, що буде виконуватись (можна, наприклад, ViewController і все у метод viewDidLoad), або ж просто створити плейграунд
  ⁃ Проєкт завантажити на Github
  ⁃ Створити гілку (branch) під назвою lesson1 у якій:
  ⁃       Буде генеруватись два рандомних числа (Int) від 1 до 500
  ⁃       Третім числом буде сума двох попередніх
  ⁃       Якщо сума менше 1000 - створиться строкa (String) з текстом "Хулі тут так мало, на пєньок сєл, должен бил косарь отдать" якщо більше і рівно 1000 - "Я із другою сімʼї, багатої"
  ⁃       Роздрукувати цю строку за допомогою print()
  ⁃       Роздрукувати скільки "важить" ця стрінга у байтах, а також, скільки "важить" кожне число (зробити висновки 😅)
  ⁃       Виконати задачу трьома способами за допомогою різних операторів умовного типу
  ⁃ Створити pull request / merge request на злиття змін з гілки lesson1 у гілку main
 */

class ViewLesson1 {
	static let shared = ViewLesson1()
	
	func getRandomValue() {
		let valueMaxNumber = 500
		let number1 = Int.random(in: 0...valueMaxNumber)
		let number2 = Int.random(in: 0...valueMaxNumber)
		
		let conditionCheckSumNumber = (number1 + number2) < 1000
		let messageTrue = "Хулі тут так мало, на пєньок сєл, должен бил косарь отдать"
		let messageFalse = "Я із другою сімʼї, багатої"
		
		// Момент по ТЗ - по умові задачі число більше 1000 ніяк не може бути, так як діапазон можливих числел від 1 до 500
		// Но якщо число таки буде більше 1000 код не зламається
		
		// 1 спосіб
		if conditionCheckSumNumber {
			print(messageTrue)
		} else {
			print(messageFalse)
		}
		
		// 2 спосіб
		conditionCheckSumNumber ? print(messageTrue) : print(messageFalse)
		
		// 3 спосіб
		guard conditionCheckSumNumber else {
			print(messageFalse)
			return
		}
		print(messageTrue)
		
		// 4 спосіб
		switch conditionCheckSumNumber {
		case true:
			print(messageTrue)
		case false:
			print(messageFalse)
		}
		
		
		// Дізнаємось скільки важить строки та числа
		let number1Size = MemoryLayout.size(ofValue: number1)
		let number2Size = MemoryLayout.size(ofValue: number2)
		
		print("Розмір строки messageTrue (типу: String) - \(messageTrue.utf8.count) байт")
		print("Розмір строки messageFalse (типу: String) - \(messageFalse.utf8.count) байт")
		print("Розмір number1 (типу: \(type(of: number1))) - \(number1Size) байт")
		print("Розмір number2 (типу: \(type(of: number2))) - \(number2Size) байт")
	}
}
