//
//  ConstraintsViewController.swift
//  SwiftStudyProject
//
//  Created by Rodion Blyshchak on 13.11.2025.
//

import UIKit

class ConstraintsViewController: UIViewController {
	enum ConstantsSize {
		static let imageHeightAnchor: CGFloat = 200
		static let imageWidthAnchor: CGFloat = 250
	}
	
	private var newTaskView = NewTaskInputView()
	private var taskListView = TaskListStackView()
	private var taskList: [String] = []
	
	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = .appWhite
		setupBackgroundImage()
		setupNewTaskInputView()
		setupTaskListStackView()
		updateTaskListView()
	}
	
	// MARK: - backgroundImage
	private func setupBackgroundImage() {
		let imageDot = UIImageView()
		imageDot.translatesAutoresizingMaskIntoConstraints = false
		imageDot.heightAnchor.constraint(equalToConstant: ConstantsSize.imageHeightAnchor).isActive = true
		imageDot.transform = CGAffineTransform(rotationAngle: .pi)
		imageDot.contentMode = .scaleAspectFill
		imageDot.image = .iconBackgroundDot
		view.addSubview(imageDot)
		
		NSLayoutConstraint.activate([
			imageDot.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			imageDot.trailingAnchor.constraint(equalTo: view.trailingAnchor),
		])
		
		let imageWavyContour = UIImageView()
		imageWavyContour.translatesAutoresizingMaskIntoConstraints = false
		imageWavyContour.heightAnchor.constraint(equalToConstant: ConstantsSize.imageHeightAnchor).isActive = true
		imageWavyContour.widthAnchor.constraint(equalToConstant: ConstantsSize.imageWidthAnchor).isActive = true
		imageWavyContour.contentMode = .scaleAspectFill
		imageWavyContour.image = .iconBackgroundWavyContour
		view.addSubview(imageWavyContour)
		
		NSLayoutConstraint.activate([
			imageWavyContour.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 80),
			imageWavyContour.topAnchor.constraint(equalTo: view.topAnchor, constant: 280),
		])
		
		let imageIntertwine = UIImageView()
		imageIntertwine.translatesAutoresizingMaskIntoConstraints = false
		imageIntertwine.heightAnchor.constraint(equalToConstant: ConstantsSize.imageHeightAnchor).isActive = true
		imageIntertwine.widthAnchor.constraint(equalToConstant: ConstantsSize.imageWidthAnchor).isActive = true
		imageIntertwine.transform = CGAffineTransform(rotationAngle: 145 * .pi / 180.0)
		imageIntertwine.contentMode = .scaleAspectFill
		imageIntertwine.image = .iconsBackgroundIntertwinesvg
		view.addSubview(imageIntertwine)
		
		NSLayoutConstraint.activate([
			imageIntertwine.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: -60),
			imageIntertwine.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -110)
		])
	}
	
	//MARK: - inputNewTask
	private func setupNewTaskInputView() {
			view.addSubview(newTaskView)
			newTaskView.translatesAutoresizingMaskIntoConstraints = false
			newTaskView.placeholderTextField(with: "New task")
			newTaskView.addTaskButtonAction = {
			self.handleAddTaskAction()
			}
			
			NSLayoutConstraint.activate([
				newTaskView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
				newTaskView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
				newTaskView.heightAnchor.constraint(equalToConstant: 60),
				newTaskView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
			])
		}
	
	private func handleAddTaskAction() {
		if let task = self.newTaskView.textFieldVaule, !task.isEmpty {
			self.taskList.append(task)
			self.updateTaskListView()
			self.newTaskView.setTextField(with: nil)
		} else {
			let alert = UIAlertController(title: "Уппс", message: "Текст не може бути порожнім!", preferredStyle: .alert)
			alert.addAction(UIAlertAction(title: "OK", style: .default))
			self.present(alert, animated: true, completion: nil)
		}
	}
	
	//MARK: - taskListView
	private func setupTaskListStackView() {
		view.addSubview(taskListView)
		taskListView.translatesAutoresizingMaskIntoConstraints = false
			
		NSLayoutConstraint.activate([
			taskListView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			taskListView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
			taskListView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
		])
	}
	
	@objc func removeTask(at index: Int) {
		guard taskList.indices.contains(index) else { return }
		taskList.remove(at: index)
		updateTaskListView()
	}
	
	func updateTaskListView() {
		taskListView.removeTaskView()
		
		for (index, task) in taskList.enumerated() {
			let taskRow = ItemTask()
			taskRow.translatesAutoresizingMaskIntoConstraints = false
			taskRow.configureTextTask(with: task)
			taskRow.setUpdateTrashButton(tag: index)
			taskRow.removeTaskButtonAction = {
				self.removeTask(at: index)
			}
			taskListView.addTaskView(taskRow)
		}
	}
}
