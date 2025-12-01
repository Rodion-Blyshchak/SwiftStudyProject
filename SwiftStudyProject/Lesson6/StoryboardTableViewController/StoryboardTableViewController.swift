//
//  StoryboardTableViewController.swift
//  SwiftStudyProject
//
//  Created by Rodion Blyshchak on 28.11.2025.
//

import UIKit

class StoryboardTableViewController: UIViewController {
	private	var taskList: [TaskItem] = []
	
	@IBOutlet weak var tableView: UITableView!
	@IBOutlet weak var textField: UITextField!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		tableView.delegate = self
		tableView.dataSource = self
		
		textField.delegate = self
	}
	
	@IBAction func AddNewTaskButtonAction(_ sender: Any?) {
		if let task = textField.text, !task.isEmpty {
			let newTask = TaskItem(titleTask: task)
			taskList.append(newTask)
			textField.text = nil
			tableView.reloadData()
		}  else {
			let alert = UIAlertController(title: "Уппс", message: "Текст не може бути порожнім!", preferredStyle: .alert)
			alert.addAction(UIAlertAction(title: "OK", style: .default))
			self.present(alert, animated: true, completion: nil)
		}
	}
}

// MARK: Extension

extension StoryboardTableViewController: UITableViewDelegate {
	func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
		return true
	}
	
	//	func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
	//		if editingStyle == .delete {
	//			taskList.remove(at: indexPath.row)
	//			tableView.deleteRows(at: [indexPath ], with: .automatic)
	//		}
	//	}
	
	func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
		let deleteTask = UIContextualAction(style: .normal, title: nil) {[weak self] (_,_, completion) in
			guard let self = self else { return completion(false) }
			self.taskList.remove(at: indexPath.row)
			tableView.deleteRows(at: [indexPath], with: .automatic)
			completion(true)
		}
		
		let pinTask = UIContextualAction(style: .normal, title: nil) {_,_, completion in
			completion(true)
		}
		deleteTask.backgroundColor = .appRed
		deleteTask.image = .trash
		
		pinTask.backgroundColor = .appBlue
		pinTask.image = .pin
		
		return UISwipeActionsConfiguration(actions: [deleteTask, pinTask])
	}
}
 
extension StoryboardTableViewController: UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		taskList.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = UITableViewCell()
		var configuration = UIListContentConfiguration.cell()
		configuration.text = taskList[indexPath.row].titleTask
		cell.contentConfiguration = configuration
		return cell
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		tableView.deselectRow(at: indexPath, animated: true)
	}
}

extension StoryboardTableViewController: UITextFieldDelegate {
	func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		AddNewTaskButtonAction(nil)
		textField.resignFirstResponder()
		return true
	}
}

