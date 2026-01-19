//
//  DescriptionCellVeloceViewController.swift
//  SwiftStudyProject
//
//  Created by Rodion Blyshchak on 15.12.2025.
//

import UIKit

protocol DescriptionCellVeloceViewControllerDelegate {
	func didTapFavoriteAction(id: String)
}

class DescriptionCellVeloceViewController: UIViewController {
	enum ConstantsSize {
		static let imageHeightAnchor: CGFloat = 300
		static let buttonHeightAnchor: CGFloat = 50
		static let buttonWidthAnchor: CGFloat = 50
		static let mainIndent: CGFloat = 16
		static let negativeMainIndent: CGFloat = -16
		static let font: CGFloat = 20
		static let fontNameCar: CGFloat = 48
		static let cornerRadius: CGFloat = 20
	}
	
	//MARK: - Properties
	var viewModel: DetailViewControllerViewModel?
	var delegate: DescriptionCellVeloceViewControllerDelegate?
	var itemID: String?
	
	private let imageView: UIImageView = {
		let image = UIImageView()
		image.translatesAutoresizingMaskIntoConstraints = false
		image.contentMode = .scaleAspectFill
		image.heightAnchor.constraint(equalToConstant: ConstantsSize.imageHeightAnchor).isActive = true
		return image
	}()
	
	private let nameCarLabel: UILabel = {
		let nameLable = UILabel()
		nameLable.translatesAutoresizingMaskIntoConstraints = false
		nameLable.textColor = .appBlack
		nameLable.font = .systemFont(ofSize: ConstantsSize.fontNameCar, weight: .bold)
		var incline = CGAffineTransform.identity
		incline.c = -0.25
		nameLable.transform = incline
		return nameLable
	}()
	
	private let teamCarLabel: UILabel = {
		let teamLable = UILabel()
		teamLable.translatesAutoresizingMaskIntoConstraints = false
		teamLable.textColor = .appGreyDark
		teamLable.font = .systemFont(ofSize: ConstantsSize.font, weight: .light)
		return teamLable
	}()
	
	private let mainInfoStackView: UIStackView = {
		let stackView = UIStackView()
		stackView.translatesAutoresizingMaskIntoConstraints = false
		stackView.axis = .vertical
		return stackView
	}()
	
	private let carDescriptionLabel: UILabel = {
		let descriptionLabel = UILabel()
		descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
		descriptionLabel.textColor = .appGreyDark
		descriptionLabel.font = .systemFont(ofSize: ConstantsSize.font, weight: .light)
		descriptionLabel.numberOfLines = 0
		return descriptionLabel
	}()
	
	lazy var favoriteStatus: Bool = false
	
	private let favoriteButton: UIButton = {
		let button = UIButton()
		button.translatesAutoresizingMaskIntoConstraints = false
		button.backgroundColor = .appBlack
		button.setTitleColor(.appWhite, for: .normal)
		button.titleLabel?.font = .systemFont(ofSize: ConstantsSize.font, weight: .bold)
		button.layer.cornerRadius = ConstantsSize.cornerRadius
		button.heightAnchor.constraint(equalToConstant: ConstantsSize.buttonHeightAnchor).isActive = true
		button.addTarget(self, action: #selector(didTapFavorite), for: .touchUpInside)
		return button
	}()

	//MARK: - Lifecycle
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		navigationController?.setNavigationBarHidden(false, animated: animated)
	}

	override func viewWillDisappear(_ animated: Bool) {
		super.viewWillDisappear(animated)
		navigationController?.setNavigationBarHidden(true, animated: animated)
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = .appWhite
		
		setupTopContent()
		setupTitle()
		setupdescription()
		setupFavoriteButton()
		
		updateFavoriteButtonState(isFavorite: favoriteStatus)
	}
	
	//MARK: - Func updateFavoriteButtonState
	// 4 пункт
	private func updateFavoriteButtonState(isFavorite: Bool) {
		self.favoriteStatus = isFavorite
		let title = isFavorite ? "Remove from Favorites" : "Add to Favorites"
		favoriteButton.setTitle(title, for: .normal)
		favoriteButton.backgroundColor = isFavorite ? .appGreyDark : .appBlack
	}
	
	//MARK: - Setup
	private func setupTopContent() {
		guard let viewModel else { return }
		
		imageView.image = viewModel.image
		
		view.addSubview(imageView)
		
		NSLayoutConstraint.activate([
			imageView.topAnchor.constraint(equalTo: view.topAnchor),
			imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
		])
	}
	
	private func setupTitle() {
		guard let viewModel else { return } // повторюється!
		
		nameCarLabel.text = viewModel.title
		teamCarLabel.text = viewModel.subTitle.uppercased()
		mainInfoStackView.addArrangedSubview(nameCarLabel)
		mainInfoStackView.addArrangedSubview(teamCarLabel)
		view.addSubview(mainInfoStackView)
		
		NSLayoutConstraint.activate([
			mainInfoStackView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20),
			mainInfoStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: ConstantsSize.mainIndent),
			mainInfoStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: ConstantsSize.negativeMainIndent)
		])
	}
	
	private func setupdescription() {
		guard let viewModel else { return }
		
		carDescriptionLabel.text = viewModel.description
		view.addSubview(carDescriptionLabel)
		
		NSLayoutConstraint.activate([
			carDescriptionLabel.topAnchor.constraint(equalTo: mainInfoStackView.bottomAnchor, constant: 24),
			carDescriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: ConstantsSize.mainIndent),
			carDescriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: ConstantsSize.negativeMainIndent)
		])
	}
	
	private func setupFavoriteButton() {
		view.addSubview(favoriteButton)
		
		NSLayoutConstraint.activate([
			favoriteButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
			favoriteButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: ConstantsSize.mainIndent),
			favoriteButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: ConstantsSize.negativeMainIndent)
		])
	}
	
	@objc private func didTapFavorite() {
		guard let id = itemID else { return }
		delegate?.didTapFavoriteAction(id: id)
	}
	
	func updateFavoriteStatus(isFavorite: Bool) {
		updateFavoriteButtonState(isFavorite: isFavorite)
	}
}
