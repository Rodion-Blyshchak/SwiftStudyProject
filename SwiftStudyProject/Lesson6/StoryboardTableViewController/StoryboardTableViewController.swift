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
		let nib = UINib(nibName: "StoryboardTableViewCell", bundle: nil)
		tableView.register(nib, forCellReuseIdentifier: "StoryboardTableViewCell")
		
		textField.delegate = self
	}
	
	private func addNewTask() {
		if let task = textField.text, !task.isEmpty {
			let newTask = TaskItem(title: task)
			taskList.append(newTask)
			textField.text = nil
			tableView.reloadData()
		}  else {
			let alert = UIAlertController(title: "Уппс", message: "Текст не може бути порожнім!", preferredStyle: .alert)
			alert.addAction(UIAlertAction(title: "OK", style: .default))
			self.present(alert, animated: true, completion: nil)
		}
	}
	
	@IBAction func addTaskButtun(_ sender: Any) {
		addNewTask()
	}
}

// MARK: Extension

extension StoryboardTableViewController: UITableViewDelegate {
	func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
		return true
	}
	
	func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
		if editingStyle == .delete {
			taskList.remove(at: indexPath.row)
			tableView.deleteRows(at: [indexPath ], with: .automatic)
		}
	}
}
 
extension StoryboardTableViewController: UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		taskList.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "StoryboardTableViewCell", for: indexPath) as! StoryboardTableViewCell
		cell.configureLableText(with: taskList[indexPath.row].title)
		return cell
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		tableView.deselectRow(at: indexPath, animated: true)
	}
}

extension StoryboardTableViewController: UITextFieldDelegate {
	func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		addNewTask()
		textField.resignFirstResponder()
		return true
	}
}

