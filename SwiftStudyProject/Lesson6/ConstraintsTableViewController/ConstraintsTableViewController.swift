//
//  ConstraintsTableViewController.swift
//  SwiftStudyProject
//
//  Created by Rodion Blyshchak on 30.11.2025.
//

import UIKit

class ConstraintsTableViewController: UIViewController {
	private let tableView = UITableView()
	private var newTaskView = NewTaskInputView() // Беру з Lesson5, щоб не створювати такий же клас
	private var taskList: [TaskItem] = []
	
	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = .appWhite
		tableView.register(ConstraintsTableViewCell.self, forCellReuseIdentifier: ConstraintsTableViewCell.reuseId)

		setupTableView()
		setupInputView()
	}
	
	// MARK: SetupFunc
	private func setupTableView() {
		tableView.separatorStyle = .none
		tableView.translatesAutoresizingMaskIntoConstraints = false
		view.addSubview(tableView)
		tableView.dataSource = self
		tableView.delegate = self
		
		NSLayoutConstraint.activate([
			tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
			tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50),
			tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
			tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16)
		])
	}
	
	private func setupInputView() {
		view.addSubview(newTaskView)
		newTaskView.translatesAutoresizingMaskIntoConstraints = false
		newTaskView.placeholderTextField(with: "New task")
		newTaskView.delegate = self
		
		NSLayoutConstraint.activate([
			newTaskView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			newTaskView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
			newTaskView.heightAnchor.constraint(equalToConstant: 60),
			newTaskView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
		])
	}
	
	private func handleAddTaskAction(text: String?) {
		if let task = text, !task.isEmpty {
			let newTask = TaskItem(title: task)
			taskList.append(newTask)
			newTaskView.setTextField(with: nil)
			tableView.reloadData()
		} else {
			let alert = UIAlertController(title: "Уппс", message: "Текст не може бути порожнім!", preferredStyle: .alert)
			alert.addAction(UIAlertAction(title: "OK", style: .default))
			self.present(alert, animated: true, completion: nil)
		}
	}
}

// MARK: Extension
extension ConstraintsTableViewController: UITableViewDelegate {
	func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
		true
	}
	
	func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
		if editingStyle == .delete {
			taskList.remove(at: indexPath.row)
			tableView.deleteRows(at: [indexPath], with: .automatic)
		}
	}
}

extension ConstraintsTableViewController: UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		taskList.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: ConstraintsTableViewCell.reuseId, for: indexPath) as! ConstraintsTableViewCell
		var confiration = UIListContentConfiguration.cell()
		confiration.text = taskList[indexPath.row].title
		cell.contentConfiguration = confiration
		return cell
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		tableView.deselectRow(at: indexPath, animated: true)
	}
}

extension ConstraintsTableViewController: NewTaskInputViewDelegate {
	func didInputNewTask(text: String?) {
		handleAddTaskAction(text: text)  
	}
}
