//
//  TaskListStackView.swift
//  SwiftStudyProject
//
//  Created by Rodion Blyshchak on 13.11.2025.
//

import UIKit

class TaskListStackView: UIView {
	private let staskView = UIStackView()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		setupkView()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	private func setupkView() {
		staskView.translatesAutoresizingMaskIntoConstraints = false
		staskView.axis = .vertical
//		staskView.spacing = 10
		staskView.alignment = .fill
		addSubview(staskView)
		
		NSLayoutConstraint.activate([
			staskView.topAnchor.constraint(equalTo: self.topAnchor, constant: 80),
			staskView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
			staskView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
			staskView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
		])
	}
	
	func addTask(_ taskRow: UIView) {
		staskView.addArrangedSubview(taskRow)
	}
	
	func removeTask() {
		staskView.arrangedSubviews.forEach {$0.removeFromSuperview()}
	}
}
