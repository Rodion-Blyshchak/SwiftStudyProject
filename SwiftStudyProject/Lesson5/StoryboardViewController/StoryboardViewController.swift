//
//  StoryboardViewController.swift
//  SwiftStudyProject
//
//  Created by Rodion Blyshchak on 06.11.2025.
//

import UIKit

class StoryboardViewController: UIViewController {
	var taskList: [String] = []
	
	@IBOutlet weak var stackTaskListView: UIStackView!
	@IBOutlet weak var textField: UITextField!
	
	override func viewDidLoad() {
		super.viewDidLoad()
	}
	
	@IBAction func addNewTaskButtonAction(_ sender: Any) {
		if let task = textField.text, !task.isEmpty {
			taskList.append(task)
			textField.text = nil
			updateTaskListView()
		}  else {
			let alert = UIAlertController(title: "Уппс", message: "Текст не може бути порожнім!", preferredStyle: .alert)
			alert.addAction(UIAlertAction(title: "OK", style: .default))
			self.present(alert, animated: true, completion: nil)
		}
	}

	@objc func removeTask(at index: Int) {
		guard taskList.indices.contains(index) else { return }
		taskList.remove(at: index)
		updateTaskListView()
	}
	
	private func updateTaskListView() {
		stackTaskListView.arrangedSubviews.forEach { $0.removeFromSuperview() }
		
		for (index, task) in taskList.enumerated() {
			let taskRow = ItemTaskStoryboardView()
			taskRow.translatesAutoresizingMaskIntoConstraints = false
			taskRow.labelText.text = task
			taskRow.taskIndex = index
			taskRow.removeTaskAction = { [weak self] receivedIndex in
				self?.removeTask(at: receivedIndex)
			}
			stackTaskListView.addArrangedSubview(taskRow)
		}
	}
}
