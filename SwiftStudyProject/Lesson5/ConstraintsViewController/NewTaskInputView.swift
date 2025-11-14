//
//  NewTaskInputView.swift
//  SwiftStudyProject
//
//  Created by Rodion Blyshchak on 13.11.2025.
//

import UIKit

class NewTaskInputView: UIView {
	lazy var textField: UITextField = {
		let input = UITextField()
		input.backgroundColor = .appGrey
		input.textColor = .appBlack
		input.layer.cornerRadius = 16
		input.heightAnchor.constraint(equalToConstant: 40).isActive = true
		return input
	}()
	
	lazy var addTaskButton: UIButton = {
		let button = UIButton()
		let buttonImage = UIImage(named: "ArrowTop")
		button.setImage(buttonImage, for: .normal)
		button.widthAnchor.constraint(equalToConstant: 40).isActive = true
		button.heightAnchor.constraint(equalToConstant: 40).isActive = true
		button.layer.cornerRadius = 20
		button.backgroundColor = .appBlue
		return button
	}()
	
	private var staskView: UIStackView = {
		let view = UIStackView()
		view.translatesAutoresizingMaskIntoConstraints = false
		view.axis = .horizontal
		view.alignment = .fill
		view.distribution = .fill
		view.spacing = 10
		return view
	}()
	
	override init(frame: CGRect) {
		super .init(frame: frame)
		setupkView()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	private func setupkView() {
		addSubview(staskView)
		staskView.addArrangedSubview(textField)
		staskView.addArrangedSubview(addTaskButton)
		
		NSLayoutConstraint.activate([
			staskView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
			staskView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
		])
	}
	
	func placeholderTextField (_ placeholder: String) {
		textField.placeholder = placeholder
	}
}
