//
//  ConstraintsViewController.swift
//  SwiftStudyProject
//
//  Created by Rodion Blyshchak on 13.11.2025.
//

import UIKit

class ConstraintsViewController: UIViewController {
	
	private var imageDot: UIImageView = {
	   var imageView = UIImageView()
		imageView.translatesAutoresizingMaskIntoConstraints = false
		imageView.heightAnchor.constraint(equalToConstant: 180).isActive = true
		imageView.transform = CGAffineTransform(rotationAngle: .pi)
		imageView.contentMode = .scaleAspectFill
		imageView.image = .iconBackgroundDot
		return imageView
	}()
	
	private var imageWavyContour: UIImageView = {
		let imageView = UIImageView()
		imageView.translatesAutoresizingMaskIntoConstraints = false
		imageView.heightAnchor.constraint(equalToConstant: 250).isActive = true
		imageView.widthAnchor.constraint(equalToConstant: 250).isActive = true
		imageView.contentMode = .scaleAspectFill
		imageView.image = .iconBackgroundWavyContour
		return imageView
	}()
	
	private var imageIntertwine: UIImageView = {
		let imageView = UIImageView()
		imageView.translatesAutoresizingMaskIntoConstraints = false
		imageView.heightAnchor.constraint(equalToConstant: 220).isActive = true
		imageView.widthAnchor.constraint(equalToConstant: 220).isActive = true
		imageView.transform = CGAffineTransform(rotationAngle: 145 * .pi / 180.0)
		imageView.contentMode = .scaleAspectFill
		imageView.image = .iconsBackgroundIntertwinesvg
		return imageView
	}()
	
	//==============================================
	private var taskList: [String] = []
	private var taskListView = TaskListStackView()
	private var newTask = NewTaskInputView()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = .appWhite
	
		setupTopImage()
		setupTasks()
		inputNewTask()

		updateTaskListView()
	}
	
	private func setupTopImage() {
		view.addSubview(imageDot)
		view.addSubview(imageWavyContour)
		view.addSubview(imageIntertwine)
		
		NSLayoutConstraint.activate([
			imageDot.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			imageDot.trailingAnchor.constraint(equalTo: view.trailingAnchor),
			imageWavyContour.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 80),
			imageWavyContour.topAnchor.constraint(equalTo: view.topAnchor, constant: 280),
			imageIntertwine.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: -60),
			imageIntertwine.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -110)
		])
	}
	
	private func setupTasks() {
		view.addSubview(taskListView)
		taskListView.translatesAutoresizingMaskIntoConstraints = false
		
		NSLayoutConstraint.activate([
			taskListView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			taskListView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
			taskListView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
//			taskListView.bottomAnchor.constraint(equalTo: newTask.topAnchor, constant: -10)
		])
	}
	
	private func inputNewTask() {
		view.addSubview(newTask)
		newTask.translatesAutoresizingMaskIntoConstraints = false
		newTask.placeholderTextField("New task")
		newTask.getAddTaskButton.addTarget(self, action: #selector(addTask), for: .touchUpInside)
		
		NSLayoutConstraint.activate([
			newTask.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			newTask.trailingAnchor.constraint(equalTo: view.trailingAnchor),
			newTask.heightAnchor.constraint(equalToConstant: 60),
			newTask.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
		])
	}
	
	//==============================================
	
	@objc func addTask() {
		if let task = newTask.getTextField, !task.isEmpty {
			taskList.append(task)
			updateTaskListView()
			newTask.setUpdateTextField(text: nil)
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
		taskListView.removeTask()
		
		for (index, task) in taskList.enumerated() {
			let taskRow = ItemTask()
			taskRow.translatesAutoresizingMaskIntoConstraints = false
			taskRow.configureTextTask(task)
			taskRow.setUpdateTrashButton(tag: index)
			taskRow.getTrashButton.addTarget(self, action: #selector(removeTask), for: .touchUpInside)
			taskListView.addTask(taskRow)
		}
	}
}
