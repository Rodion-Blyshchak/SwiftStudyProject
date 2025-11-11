//
//  ConstraintsViewController.swift
//  SwiftStudyProject
//
//  Created by Rodion Blyshchak on 06.11.2025.
//

import UIKit

class ConstraintsViewController: UIViewController {
	var taskList: [String] = []
	let newTaskInputView = NewTaskView.shared
	let removeTaskInputView = ItemTask.shared
	let taskListManager = TaskListStackView.shared
	
	override func viewDidLoad() {
		view.backgroundColor = .appWhite
		AllImage.shared.imageDot(to: self.view, name: "IconBackgroundDot")
		AllImage.shared.imageWavyContour(to: self.view, name: "IconBackgroundWavyContour")
		AllImage.shared.imageIntertwine(to: self.view, name: "IconsBackgroundIntertwinesvg")
		newTaskInputView.stackView(to: self.view, withPlaceholder: "New task")
		newTaskInputView.addNewTaskButton.addTarget(self, action: #selector(addTask), for: .touchUpInside)
		TaskListStackView.shared.taskListView(to: newTaskInputView)
		taskListManager.taskListView(to: self.view)
		updateTaskListView()
	}
	
	@objc func addTask() {
		if let taskText = newTaskInputView.textFieldView.text, !taskText.isEmpty {
			taskList.append(taskText)
			updateTaskListView()
			newTaskInputView.textFieldView.text = nil
			print(taskList)
		} else {
			let alert = UIAlertController(title: "Уппс", message: "Текст не може бути порожнім!", preferredStyle: .alert)
			alert.addAction(UIAlertAction(title: "OK", style: .default))
			self.present(alert, animated: true, completion: nil)
		}
	}
	
	@objc func removeTask(sender: UIButton) {
			let indexToRemove = sender.tag
			guard taskList.indices.contains(indexToRemove) else { return }
			taskList.remove(at: indexToRemove)
			updateTaskListView()
		}

	func updateTaskListView() {
			taskListManager.clearAllTasks()
		
			for (index, task) in taskList.enumerated() {
				guard let taskRow = ItemTask.shared.itemTaskView(textTask: task) else { continue }

				if let trashButton = taskRow.arrangedSubviews.last as? UIButton {
					trashButton.tag = index
					trashButton.addTarget(self, action: #selector(removeTask), for: .touchUpInside)
				}
				taskListManager.addTaskView(taskRow)
			}
		}
}
