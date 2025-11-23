//
//  ItemTask.swift
//  SwiftStudyProject
//
//  Created by Rodion Blyshchak on 13.11.2025.
//

import UIKit

class ItemTaskView: UIView {
	enum ConstantsSize {
		static let heightAnchor: CGFloat = 30
		static let widthAnchor: CGFloat = 30
		static let spacingElements: CGFloat = 10
		static let sizeFont: CGFloat = 20
	}
	
	private var checkboxButton: UIButton = {
		let checkbox = UIButton()
		let uncheckedImage = UIImage(systemName: "square")
		checkbox.setImage(uncheckedImage, for: .normal)
		checkbox.tintColor = .appBlack
		checkbox.widthAnchor.constraint(equalToConstant: ConstantsSize.widthAnchor).isActive = true
		checkbox.heightAnchor.constraint(equalToConstant: ConstantsSize.spacingElements).isActive = true
		return checkbox
	}()
	
	private var textTaskLabel: UILabel = {
		let text = UILabel()
		text.textColor = .appBlack
		text.font = .systemFont(ofSize: ConstantsSize.sizeFont, weight: .medium)
		text.numberOfLines = 2
		return text
	}()
	
	private lazy var trashButton: UIButton = {
		let button = UIButton()
		let imageButton = UIImage(systemName: "trash")
		button.setImage(imageButton, for: .normal)
		button.tintColor = .appRed
		button.widthAnchor.constraint(equalToConstant: ConstantsSize.widthAnchor).isActive = true
		button.heightAnchor.constraint(equalToConstant: ConstantsSize.heightAnchor).isActive = true
		button.addTarget(self, action: #selector(removeTask), for: .touchUpInside)
		return button
	}()
	
	private var staskView: UIStackView = {
		let view = UIStackView()
		view.translatesAutoresizingMaskIntoConstraints = false
		view.axis = .horizontal
		view.alignment = .center
		view.distribution = .fill
		view.spacing = ConstantsSize.spacingElements
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
	
	func configureTextTask(with text: String) {
		textTaskLabel.text = text
	}
	
	func setUpdateTrashButton(tag: Int) {
		trashButton.tag = tag
	}
	
	var removeTaskButtonAction: (() -> Void)?
	
	@objc func removeTask() {
		removeTaskButtonAction?()
	}
}
