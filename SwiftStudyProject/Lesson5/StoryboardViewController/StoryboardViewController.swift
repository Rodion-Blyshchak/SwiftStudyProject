//
//  StoryboardViewController.swift
//  SwiftStudyProject
//
//  Created by Rodion Blyshchak on 06.11.2025.
//

import UIKit

class StoryboardViewController: UIViewController {
	var taskList: [String] = []
	
	@IBOutlet weak var StackTaskListView: UIStackView!
	@IBOutlet weak var textFieldOutlet: UITextField!
	
	override func viewDidLoad() {
		super.viewDidLoad()
	}
	
	@IBAction func addNewTaskButtonAction(_ sender: Any) {
		if let task = textFieldOutlet.text, !task.isEmpty {
			taskList.append(task)
			textFieldOutlet.text = nil
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
		StackTaskListView.arrangedSubviews.forEach { $0.removeFromSuperview() }
		
		for (index, task) in taskList.enumerated() {
			let taskRow = ItemTaskStoryboardView()
			taskRow.translatesAutoresizingMaskIntoConstraints = false
			taskRow.LabelOutlet.text = task
			taskRow.taskIndex = index
			taskRow.removeTaskAction = { [weak self] receivedIndex in
				self?.removeTask(at: receivedIndex)
			}
			StackTaskListView.addArrangedSubview(taskRow)
		}
	}
}
