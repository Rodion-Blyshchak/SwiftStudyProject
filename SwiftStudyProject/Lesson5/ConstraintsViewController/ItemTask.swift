//
//  ItemTask.swift
//  SwiftStudyProject
//
//  Created by Rodion Blyshchak on 13.11.2025.
//

import UIKit

class ItemTask: UIView {
	private var checkboxButton: UIButton = {
		let checkbox = UIButton()
		let uncheckedImage = UIImage(systemName: "square")
		checkbox.setImage(uncheckedImage, for: .normal)
		checkbox.tintColor = .appBlack
		checkbox.widthAnchor.constraint(equalToConstant: 30).isActive = true
		checkbox.heightAnchor.constraint(equalToConstant: 30).isActive = true
		return checkbox
	}()
	
	private var textTaskLabel: UILabel = {
		let text = UILabel()
		text.textColor = .appBlack
		text.font = .systemFont(ofSize: 20, weight: .medium)
		text.numberOfLines = 2
		return text
	}()
	
	lazy var trashButton: UIButton = {
		let button = UIButton()
		let imageButton = UIImage(systemName: "trash")
		button.setImage(imageButton, for: .normal)
		button.tintColor = .appRed
		button.widthAnchor.constraint(equalToConstant: 30).isActive = true
		button.heightAnchor.constraint(equalToConstant: 30).isActive = true
		return button
	}()
	
	private var staskView: UIStackView = {
		let view = UIStackView()
		view.translatesAutoresizingMaskIntoConstraints = false
		view.axis = .horizontal
		view.alignment = .center
		view.distribution = .fill
		view.spacing = 10
		view.isLayoutMarginsRelativeArrangement = true
		view.layoutMargins = UIEdgeInsets(top: 5, left: 20, bottom: 5, right: 20)
		return view
	}()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		setupView()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	private func setupView() {
		addSubview(staskView)
		staskView.addArrangedSubview(checkboxButton)
		staskView.addArrangedSubview(textTaskLabel)
		staskView.addArrangedSubview(trashButton)
		
		NSLayoutConstraint.activate([
			staskView.topAnchor.constraint(equalTo: self.topAnchor),
			staskView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
			staskView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
			staskView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
		])
	}
	
	func configureTextTask(_ text: String) {
		textTaskLabel.text = text
	}
}
