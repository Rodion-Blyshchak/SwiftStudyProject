//
//  NewTaskInputView.swift
//  SwiftStudyProject
//
//  Created by Rodion Blyshchak on 13.11.2025.
//

import UIKit

protocol NewTaskInputViewDelegate {
	func didInputNewTask(text: String?)
}

class NewTaskInputView: UIView {
	enum ConstantsSize {
		static let cornerRadius: CGFloat = 16
		static let heightAnchor: CGFloat = 40
		static let widthAnchor: CGFloat = 40
		static let spacingElements: CGFloat = 10
		static let leadingAnchor: CGFloat = 20
		static let trailingAnchor: CGFloat = -20
	}
	
	private var textField: UITextField = {
		let input = UITextField()
		input.backgroundColor = .appGrey
		input.textColor = .appBlack
		input.layer.cornerRadius = ConstantsSize.cornerRadius
		input.heightAnchor.constraint(equalToConstant: ConstantsSize.heightAnchor).isActive = true
		return input
	}()
	
	private lazy var addTaskButton: UIButton = {
		let button = UIButton()
		let buttonImage = UIImage(named: "ArrowTop")
		button.setImage(buttonImage, for: .normal)
		button.widthAnchor.constraint(equalToConstant: ConstantsSize.widthAnchor).isActive = true
		button.heightAnchor.constraint(equalToConstant: ConstantsSize.heightAnchor).isActive = true
		button.layer.cornerRadius = ConstantsSize.cornerRadius
		button.backgroundColor = .appBlue
		button.addTarget(self, action: #selector(addTask), for: .touchUpInside)
		return button
	}()
	
	private var staskView: UIStackView = {
		let view = UIStackView()
		view.translatesAutoresizingMaskIntoConstraints = false
		view.axis = .horizontal
		view.alignment = .fill
		view.distribution = .fill
		view.spacing = ConstantsSize.spacingElements
		return view
	}()
	
	override init(frame: CGRect) {
		super .init(frame: frame)
		setupView()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	private func setupView() {
		addSubview(staskView)
		staskView.addArrangedSubview(textField)
		staskView.addArrangedSubview(addTaskButton)
		
		NSLayoutConstraint.activate([
			staskView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: ConstantsSize.leadingAnchor),
			staskView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: ConstantsSize.trailingAnchor),
		])
	}
	
	func placeholderTextField (with placeholder: String) {
		textField.placeholder = placeholder
	}
	
	func setTextField(with text: String?) {
		textField.text = text
	}
	
	var textFieldVaule: String? {
		textField.text
	}
	
//	var addTaskButtonAction: (() -> Void)?
	
	@objc func addTask() {
		delegate?.didInputNewTask(text: textField.text)
	}
	
	var delegate: NewTaskInputViewDelegate?
}

// other class
// NewTaskInputView.textField.text - напряму -> NewTaskInputView.getText()
// getText -> return textField.text
