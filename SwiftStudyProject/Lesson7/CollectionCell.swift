//
//  CollectionCell.swift
//  SwiftStudyProject
//
//  Created by Rodion Blyshchak on 13.12.2025.
//

import UIKit

class CollectionCell: UICollectionViewCell {
	static let reuseId = "CollectionCell"
	
	private let imageCell: UIImageView = {
		let image = UIImageView()
		image.translatesAutoresizingMaskIntoConstraints = false
		image.contentMode = .scaleAspectFill
		image.layer.cornerRadius = 8
		image.clipsToBounds = true
		return image
	}()
	
	private let titleCell: UILabel = {
		let title = UILabel()
		title.translatesAutoresizingMaskIntoConstraints = false
		title.textColor = .appBlack
		title.font = .systemFont(ofSize: 24, weight: .medium)
		title.numberOfLines = 0
		return title
	}()
	
	private let subTitleCell: UILabel = {
		let sub = UILabel()
		sub.translatesAutoresizingMaskIntoConstraints = false
		sub.textColor = .appGreyDark
		sub.font = .systemFont(ofSize: 16, weight: .medium)
		sub.numberOfLines = 0
		return sub
	}()
	
	private let stackView: UIStackView = {
		let stack = UIStackView()
		stack.translatesAutoresizingMaskIntoConstraints = false
		stack.axis = .vertical
		stack.alignment = .fill
		stack.distribution = .fill
		stack.spacing = 4
		return stack
	}()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		setupView()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	private func setupView() {
		contentView.addSubview(stackView)
		stackView.addArrangedSubview(imageCell)
		stackView.addArrangedSubview(titleCell)
		stackView.addArrangedSubview(subTitleCell)
		contentView.clipsToBounds = true
		
		NSLayoutConstraint.activate([
			imageCell.heightAnchor.constraint(equalToConstant: 120),
			imageCell.widthAnchor.constraint(equalToConstant: 173),
			
			stackView.topAnchor.constraint(equalTo: self.topAnchor),
			stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
			stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
			stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
		])
	}
	
	func configure(with item: CollectionCellStruct) {
		imageCell.image = item.image
		titleCell.text = item.title
		subTitleCell.text = item.subtitle.uppercased()
	}
}
