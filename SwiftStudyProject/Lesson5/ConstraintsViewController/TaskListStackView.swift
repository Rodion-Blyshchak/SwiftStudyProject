//
//  TaskListStackView.swift
//  SwiftStudyProject
//
//  Created by Rodion Blyshchak on 11.11.2025.
//
import UIKit

class TaskListStackView {
	static let shared = TaskListStackView()
	
	let stack = UIStackView()
	
	func taskListView(to parentView: UIView) {
		stack.translatesAutoresizingMaskIntoConstraints = false
		stack.axis = .vertical
		stack.spacing = 10
		stack.alignment = .fill
		parentView.addSubview(stack)
		
		NSLayoutConstraint.activate([
			stack.topAnchor.constraint(equalTo: parentView.safeAreaLayoutGuide.topAnchor, constant: 20),
			stack.leadingAnchor.constraint(equalTo: parentView.leadingAnchor),
			stack.trailingAnchor.constraint(equalTo: parentView.trailingAnchor),
		])
	}
	
	func addTaskView(_ taskRow: UIView) {
		stack.addArrangedSubview(taskRow)
	}

	func clearAllTasks() {
		stack.arrangedSubviews.forEach { $0.removeFromSuperview() }
	}
}
