//
//  ConstraintsViewController.swift
//  SwiftStudyProject
//
//  Created by Rodion Blyshchak on 13.11.2025.
//

import UIKit

// MARK: - Something
class ConstraintsViewController: UIViewController {
    enum Constants {
        static let imageDotSize: CGFloat = 200
    }
    
    private var newTaskView = NewTaskInputView()
    private var taskListStackView = TaskListStackView()
	private var taskList: [String] = []
	
	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = .appWhite
	
		setupBackground()
		
        setupTaskListStackView()
        setupNewTaskInputView()

		updateTaskListView()
        
        /*
        let testView = SomeTestView()
        view.addSubview(testView)
        testView.setup(text: "Hello!")
        
        testView.translatesAutoresizingMaskIntoConstraints = false
        testView.heightAnchor.constraint(equalToConstant: 60).isActive = true
        testView.widthAnchor.constraint(equalToConstant: 60).isActive = true
        
        NSLayoutConstraint.activate([
            testView.trailingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            testView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100)
        ])
         */
	}
	
    // MARK: - Private funcs
    
	private func setupBackground() {
        var imageDot = UIImageView()
        imageDot.translatesAutoresizingMaskIntoConstraints = false
        imageDot.heightAnchor.constraint(equalToConstant: 180).isActive = true
        imageDot.transform = CGAffineTransform(rotationAngle: .pi)
        imageDot.contentMode = .scaleAspectFill
        imageDot.image = .iconBackgroundDot
        
		view.addSubview(imageDot)
		
		NSLayoutConstraint.activate([
			imageDot.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			imageDot.trailingAnchor.constraint(equalTo: view.trailingAnchor)
		])
        
        let imageWavyContour = UIImageView()
        imageWavyContour.translatesAutoresizingMaskIntoConstraints = false
        imageWavyContour.heightAnchor.constraint(equalToConstant: Constants.imageDotSize).isActive = true
        imageWavyContour.widthAnchor.constraint(equalToConstant: Constants.imageDotSize).isActive = true
        imageWavyContour.contentMode = .scaleAspectFill
        imageWavyContour.image = .iconBackgroundWavyContour
        
        view.addSubview(imageWavyContour)
        
        NSLayoutConstraint.activate([
            imageWavyContour.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 80),
            imageWavyContour.topAnchor.constraint(equalTo: view.topAnchor, constant: 280)
        ])
        
        let imageIntertwine = UIImageView()
        imageIntertwine.translatesAutoresizingMaskIntoConstraints = false
        imageIntertwine.heightAnchor.constraint(equalToConstant: 220).isActive = true
        imageIntertwine.widthAnchor.constraint(equalToConstant: 220).isActive = true
        imageIntertwine.transform = CGAffineTransform(rotationAngle: 145 * .pi / 180.0)
        imageIntertwine.contentMode = .scaleAspectFill
        imageIntertwine.image = .iconsBackgroundIntertwinesvg

        view.addSubview(imageIntertwine)
        
        NSLayoutConstraint.activate([
            imageIntertwine.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: -60),
            imageIntertwine.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -110)
        ])
	}
	
	private func setupTaskListStackView() {
		view.addSubview(taskListStackView)
		taskListStackView.translatesAutoresizingMaskIntoConstraints = false
		
		NSLayoutConstraint.activate([
			taskListStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			taskListStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
			taskListStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
//			taskListView.bottomAnchor.constraint(equalTo: newTask.topAnchor, constant: -10)
		])
	}
	
	private func setupNewTaskInputView() {
		view.addSubview(newTaskView)
		newTaskView.translatesAutoresizingMaskIntoConstraints = false
		newTaskView.placeholderTextField("New task")
        newTaskView.addTaskButtonAction = {
            if let task = self.newTaskView.textFieldText, !task.isEmpty {
                self.taskList.append(task)
                self.updateTaskListView()
                self.newTaskView.setTextField(with: nil)
            } else {
                let alert = UIAlertController(title: "Уппс", message: "Текст не може бути порожнім!", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default))
                self.present(alert, animated: true, completion: nil)
            }
        }
//		newTask.getAddTaskButton.addTarget(self, action: #selector(addTask), for: .touchUpInside)
		
		NSLayoutConstraint.activate([
			newTaskView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			newTaskView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
			newTaskView.heightAnchor.constraint(equalToConstant: 60),
			newTaskView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
		])
	}
	
	//==============================================
	
//	@objc func addTask() {
//		
//	}
	
	@objc func removeTask(sender: UIButton) {
		let indexToRemove = sender.tag
		guard taskList.indices.contains(indexToRemove) else { return }
		taskList.remove(at: indexToRemove)
		updateTaskListView()
	}
	
	func updateTaskListView() {
		taskListStackView.removeTask()
		
		for (index, task) in taskList.enumerated() {
			let taskRow = ItemTask()
			taskRow.translatesAutoresizingMaskIntoConstraints = false
			taskRow.configureTextTask(task)
			taskRow.setUpdateTrashButton(tag: index)
			taskRow.getTrashButton.addTarget(self, action: #selector(removeTask), for: .touchUpInside)
			taskListStackView.addTask(taskRow)
		}
	}
}
