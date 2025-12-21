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
	
	private let imageView: UIImageView = {
		let imageView = UIImageView()
		imageView.translatesAutoresizingMaskIntoConstraints = false
		imageView.contentMode = .scaleAspectFill
		imageView.layer.cornerRadius = ConstantsSize.cornerRadius
		imageView.clipsToBounds = true
		return imageView
	}()
	
	private let titleLabel: UILabel = {
		let titleLabel = UILabel()
		titleLabel.translatesAutoresizingMaskIntoConstraints = false
		titleLabel.textColor = .appBlack
		titleLabel.font = .systemFont(ofSize: ConstantsSize.fontTitle, weight: .medium)
		titleLabel.numberOfLines = 0
		return titleLabel
	}()
	
	private let subtitleLabel: UILabel = {
		let subtitleLabel = UILabel()
		subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
		subtitleLabel.textColor = .appGreyDark
		subtitleLabel.font = .systemFont(ofSize: ConstantsSize.fontSubTitle, weight: .medium)
		subtitleLabel.numberOfLines = 0
		return subtitleLabel
	}()
	
	private let stackView: UIStackView = {
		let stackView = UIStackView()
		stackView.translatesAutoresizingMaskIntoConstraints = false
		stackView.axis = .vertical
		stackView.alignment = .fill
		stackView.distribution = .fill
		stackView.spacing = ConstantsSize.spacing
		return stackView
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
		stackView.addArrangedSubview(imageView)
		stackView.addArrangedSubview(titleLabel)
		stackView.addArrangedSubview(subtitleLabel)
		contentView.clipsToBounds = true
		
		NSLayoutConstraint.activate([
			imageView.heightAnchor.constraint(equalToConstant: ConstantsSize.heightView),
			
			stackView.topAnchor.constraint(equalTo: self.topAnchor),
			stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
			stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
			stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
		])
	}
	
	func configure(with item: CollectionViewCellViewModel) {
		imageView.image = item.image
		titleLabel.text = item.title
		subtitleLabel.text = item.subTitle.uppercased()
	}
}
