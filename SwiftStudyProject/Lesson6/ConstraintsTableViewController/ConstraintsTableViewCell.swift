//
//  ConstraintsTableViewCell.swift
//  SwiftStudyProject
//
//  Created by Rodion Blyshchak on 05.12.2025.
//

import UIKit

class ConstraintsTableViewCell: UITableViewCell {
	static let reuseId = "ConstraintsTableViewCell"
	
	private var lable: UILabel = {
		let lable = UILabel()
		lable.textColor = .appBlack
		lable.font = .systemFont(ofSize: 20, weight: .medium)
		lable.numberOfLines = 2
		return lable
	}()
	
	// imageView уже використовується у UITableViewCell - open var imageView: UIImageView? { get }
	private var iconView: UIImageView = {
		let image = UIImageView()
		image.translatesAutoresizingMaskIntoConstraints = false
		image.heightAnchor.constraint(equalToConstant: 30).isActive = true
		image.contentMode = .scaleAspectFit
		image.image = .iconBackgroundSpiral
		image.clipsToBounds = true
		return image
	}()
	
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		setupTableViewCell()
	}
	
	private var stackView: UIStackView = {
		let view = UIStackView()
		view.translatesAutoresizingMaskIntoConstraints = false
		view.backgroundColor = .appGrey
		view.axis = .horizontal
		view.alignment = .center
		view.distribution = .fill
		view.spacing = 10
		view.isLayoutMarginsRelativeArrangement = true
		view.layoutMargins = UIEdgeInsets(top: 5, left: 20, bottom: 5, right: 20)
		return view
	}()
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	private func setupTableViewCell() {
		addSubview(stackView)
		stackView.addArrangedSubview(lable)
		stackView.addArrangedSubview(iconView)
		
		NSLayoutConstraint.activate([
			stackView.topAnchor.constraint(equalTo: self.topAnchor),
			stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
			stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
			stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
		])
	}
}
