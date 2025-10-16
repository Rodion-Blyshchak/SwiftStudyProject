/*
 2й тиждень:

 Теорія:
 - Array, Dictionary, Set, у чому відмінності, де застосовується і де зберігається у памʼяті
 - Reference type vs Value type / heap vs stack (почитати теорію, а потім розказати мені)
 - Оператори циклу: for, while, forEach
 - Задачка з зірочкою: числа Фібоначчі

 Практика:
 - Для цього ж проекту створити гілку Lesson2 на GitHub
 - У проекті створити класс Lesson2 (або що завгодно, що буде виконуватись) і зробити наступні дії:

 - Уявляємо, що Dictionary - це щоденник школяра, у якому ключами (key) будуть назви предметів, а значеннями (value) - оцінки за цей предмет. Нехай буде 5-7 предметів, з максимальною оцінкою 12 (як у школі).
 - Створити 20 щоденників школярів з випадковими оцінками за предмети:
	- Спочатку можеш зробити це «ручками», набити памʼять, як це працює
	- Потім створити їх за допомогою оператору циклу (for)
 - Роздрукувати у консоль ці 20 словників, але за допомогою оператору forEach
 - Разом із цим, роздрукувати для кожного учня середній бал за усі предмети
 - І врешті решт, роздрукувати загальний середній бал класу, щоб зрозуміти, чи отримає класний керівник грамоту від РАЙОНО (я не знаю, що це, та мені запало це слово у душу)
 - Якщо середній бал вище 8 - напиши в консоль «Ще поживемо», якщо нижче «Спробуємо ще наступного року»

 - Задачка із зірочкою: роздрукувати у консоль перші N чисел Фібоначчі:
	 - за допомогою циклу
	 - за допомогою рекурсії (почитати, що це таке)
*/

class ViewLesson2 {
	static let shared = ViewLesson2()
	
	func studentAndClassResults() {
		let listSubjects = ["Алгебра", "Геометрія", "Фізика", "Історія", "Українська мова", "Українська література", "Англійська мова"]
		let listStudent = ["Антон", "Аліна", "Василь", "Вікторія", "Богдан", "Дарина", "Єгор", "Саша", "Женя", "Яна", "Максим", "Олена", "Олег", "Поліна", "Рома", "Софія", "Коля", "Маша", "Андрій", "Христина"]
		
		var resultOneStudent: [String: Int] = [:]
		var dictionaryLearningOutcomes: [String: [String: Int]] = [:]
		var dictionaryGradePointAverageStudents: [String: Int] = [:]
		
		for studentResults in listStudent {
			
			for itemSubjects in listSubjects {
				let randomAssessment = Int.random(in: 1...12)
				resultOneStudent[itemSubjects] = randomAssessment
			}
			
			dictionaryLearningOutcomes[studentResults] = resultOneStudent
		}
		
		dictionaryLearningOutcomes.forEach { dictionaryItem in
			print("\(dictionaryItem.key) та його/її оцінки - \(dictionaryItem.value)")
		}
		
		for averageScore in dictionaryLearningOutcomes {
			let sumPointsOneStudent = averageScore.value.values.reduce(0, +)
			let averageScoreOneStudent = Double(sumPointsOneStudent)/Double(averageScore.value.values.count)
			dictionaryGradePointAverageStudents[averageScore.key] = Int(averageScoreOneStudent.rounded())
		}
		
		print("Середній бал учнів - \(dictionaryGradePointAverageStudents)")
		
		let classAverage = Double(dictionaryGradePointAverageStudents.values.reduce(0, +)) / Double(dictionaryGradePointAverageStudents.count)
		print("Результати класу - \(Int(classAverage)) \(Int(classAverage) > 8 ? "Ще поживемо" : "Спробуємо ще наступного року")")
	}
}
