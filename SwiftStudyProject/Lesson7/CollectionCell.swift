//
//  CollectionCell.swift
//  SwiftStudyProject
//
//  Created by Rodion Blyshchak on 13.12.2025.
//

import UIKit

class CollectionCell: UICollectionViewCell {
	enum ConstantsSize {
		static let heightView: CGFloat = 120
		static let widthView: CGFloat = 173
		static let numberOfLines: CGFloat = 0
		static let fontTitle: CGFloat = 24
		static let fontSubTitle: CGFloat = 16
		static let cornerRadius: CGFloat = 8
		static let spacing: CGFloat = 4
	}
	
	static let reuseId = "CollectionCell"
	
	private let imageCell: UIImageView = {
		let image = UIImageView()
		image.translatesAutoresizingMaskIntoConstraints = false
		image.contentMode = .scaleAspectFill
		image.layer.cornerRadius = ConstantsSize.cornerRadius
		image.clipsToBounds = true
		return image
	}()
	
	private let titleCell: UILabel = {
		let title = UILabel()
		title.translatesAutoresizingMaskIntoConstraints = false
		title.textColor = .appBlack
		title.font = .systemFont(ofSize: ConstantsSize.fontTitle, weight: .medium)
		title.numberOfLines = 0
		return title
	}()
	
	private let subTitleCell: UILabel = {
		let sub = UILabel()
		sub.translatesAutoresizingMaskIntoConstraints = false
		sub.textColor = .appGreyDark
		sub.font = .systemFont(ofSize: ConstantsSize.fontSubTitle, weight: .medium)
		sub.numberOfLines = 0
		return sub
	}()
	
	private let stackView: UIStackView = {
		let stack = UIStackView()
		stack.translatesAutoresizingMaskIntoConstraints = false
		stack.axis = .vertical
		stack.alignment = .fill
		stack.distribution = .fill
		stack.spacing = ConstantsSize.spacing
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
			imageCell.heightAnchor.constraint(equalToConstant: ConstantsSize.heightView),
			imageCell.widthAnchor.constraint(equalToConstant: ConstantsSize.widthView),
			
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
