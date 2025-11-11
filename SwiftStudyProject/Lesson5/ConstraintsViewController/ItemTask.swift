//
//  AllImage.swift
//  SwiftStudyProject
//
//  Created by Rodion Blyshchak on 09.11.2025.
//

import UIKit

class ItemTask {
	static let shared = ItemTask()
	
	func itemTaskView(textTask: String) -> UIStackView? {
		let checkboxButton = UIButton(type: .system)
		let uncheckedImage = UIImage(systemName: "square")
		checkboxButton.setImage(uncheckedImage, for: .normal)
		checkboxButton.tintColor = .appBlack
		checkboxButton.widthAnchor.constraint(equalToConstant: 30).isActive = true
		checkboxButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
		
		let textTaskLabel = UILabel()
		textTaskLabel.text = textTask
		textTaskLabel.textColor = .appBlack
		textTaskLabel.font = .systemFont(ofSize: 20, weight: .medium)
		textTaskLabel.numberOfLines = 2
		
		let trashButton = UIButton()
		let trasgImage = UIImage(systemName: "trash")
		trashButton.setImage(trasgImage, for: .normal)
		trashButton.tintColor = .appRed
		trashButton.widthAnchor.constraint(equalToConstant: 30).isActive = true
		trashButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
		
		let taskStack = UIStackView()
		taskStack.translatesAutoresizingMaskIntoConstraints = false
		taskStack.axis = .horizontal
		taskStack.alignment = .center
		taskStack.distribution = .fill
		taskStack.spacing = 10
		taskStack.isLayoutMarginsRelativeArrangement = true
		taskStack.layoutMargins = UIEdgeInsets(top: 5, left: 20, bottom: 5, right: 20)
		taskStack.addArrangedSubview(checkboxButton)
		taskStack.addArrangedSubview(textTaskLabel)
		taskStack.addArrangedSubview(trashButton)
		
		return taskStack
	}
}
