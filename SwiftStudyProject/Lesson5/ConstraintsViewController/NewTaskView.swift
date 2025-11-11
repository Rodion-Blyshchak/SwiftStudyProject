//
//  NewTaskView.swift
//  SwiftStudyProject
//
//  Created by Rodion Blyshchak on 10.11.2025.
//

import UIKit


class NewTaskView: UIView {
	static let shared = NewTaskView()
	
	let textFieldView = UITextField()
	let addNewTaskButton = UIButton()
	
	func stackView(to parentView: UIView, withPlaceholder placeholder: String) {
		textFieldView.translatesAutoresizingMaskIntoConstraints = false
		textFieldView.placeholder = placeholder
		textFieldView.backgroundColor = .appGrey
		textFieldView.textColor = .appBlack
		textFieldView.layer.cornerRadius = 16
		textFieldView.heightAnchor.constraint(equalToConstant: 40).isActive = true
		
		addNewTaskButton.translatesAutoresizingMaskIntoConstraints = false
		addNewTaskButton.widthAnchor.constraint(equalToConstant: 40).isActive = true
		addNewTaskButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
		addNewTaskButton.layer.cornerRadius = 20
		addNewTaskButton.backgroundColor = .appBlye
		let buttonImage = UIImage(named: "ArrowTop")
		addNewTaskButton.setImage(buttonImage, for: .normal)
		
		let stack = UIStackView()
		stack.translatesAutoresizingMaskIntoConstraints = false
		stack.axis = .horizontal
		stack.alignment = .fill
		stack.distribution = .fill
		stack.spacing = 10
		stack.addArrangedSubview(textFieldView)
		stack.addArrangedSubview(addNewTaskButton)
		parentView.addSubview(stack)
		
		NSLayoutConstraint.activate([
			stack.leadingAnchor.constraint(equalTo: parentView.leadingAnchor, constant: 20),
			stack.trailingAnchor.constraint(equalTo: parentView.trailingAnchor, constant: -20),
			stack.bottomAnchor.constraint(equalTo: parentView.bottomAnchor, constant: -40)
		])
	}
}

