//
//  DescriptionCellVeloceViewController.swift
//  SwiftStudyProject
//
//  Created by Rodion Blyshchak on 15.12.2025.
//

import UIKit

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
	
	var viewModel: DetailViewControllerViewModel?

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
		setupButton()
	}
	
	//MARK: - TopContent
	private let imageView: UIImageView = {
		let image = UIImageView()
		image.translatesAutoresizingMaskIntoConstraints = false
		image.contentMode = .scaleAspectFill
		image.heightAnchor.constraint(equalToConstant: ConstantsSize.imageHeightAnchor).isActive = true
		return image
	}()
	
	private func setupTopContent() {
		guard let viewModel else { return }
		
		imageView.image = viewModel.image
		
		view.addSubview(imageView)
		
		NSLayoutConstraint.activate([
			imageView.topAnchor.constraint(equalTo: view.topAnchor),
			imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
		])
		
		let likeButton = UIButton()
		let buttonImage = UIImage(named: "likeIcon")?.withRenderingMode(.alwaysTemplate)
		likeButton.setImage(buttonImage, for: .normal)
		if #available(iOS 26.0, *) {
			likeButton.backgroundColor = .clear
		} else if #available(iOS 15.0, *) {
			likeButton.backgroundColor = .appWhite
			likeButton.layer.borderWidth = 1.0
			likeButton.layer.borderColor = UIColor(named: "appGreyDark")?.cgColor
		}
		likeButton.tintColor = .appBlack
		likeButton.translatesAutoresizingMaskIntoConstraints = false
		likeButton.widthAnchor.constraint(equalToConstant: ConstantsSize.buttonWidthAnchor).isActive = true
		likeButton.heightAnchor.constraint(equalToConstant: ConstantsSize.buttonHeightAnchor).isActive = true
		likeButton.layer.cornerRadius = ConstantsSize.buttonWidthAnchor / 2
		view.addSubview(likeButton)
		
		NSLayoutConstraint.activate([
			likeButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 60),
			likeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: ConstantsSize.negativeMainIndent)
		])
	}
	
	//MARK: - Title
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
	
	//MARK: - Description
	private let descriptionCar: UILabel = {
		let description = UILabel()
		description.translatesAutoresizingMaskIntoConstraints = false
		description.textColor = .appGreyDark
		description.font = .systemFont(ofSize: ConstantsSize.font, weight: .light)
		description.numberOfLines = 0
		return description
	}()
	
	private func setupdescription() {
		guard let viewModel else { return }
		
		descriptionCar.text = viewModel.description
		view.addSubview(descriptionCar)
		
		NSLayoutConstraint.activate([
			descriptionCar.topAnchor.constraint(equalTo: mainInfoStackView.bottomAnchor, constant: 24),
			descriptionCar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: ConstantsSize.mainIndent),
			descriptionCar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: ConstantsSize.negativeMainIndent)
		])
	}
	
	//MARK: - Button
	private let addButton: UIButton = {
		let button = UIButton()
		button.translatesAutoresizingMaskIntoConstraints = false
		button.backgroundColor = .appBlack
		button.setTitle("Add", for: .normal)
		button.setTitleColor(.appWhite, for: .normal)
		button.titleLabel?.font = .systemFont(ofSize: ConstantsSize.font, weight: .bold)
		button.layer.cornerRadius = ConstantsSize.cornerRadius
		button.heightAnchor.constraint(equalToConstant: ConstantsSize.buttonHeightAnchor).isActive = true
		return button
	}()
	
	private func setupButton() {
		view.addSubview(addButton)
		
		NSLayoutConstraint.activate([
			addButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
			addButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: ConstantsSize.mainIndent),
			addButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: ConstantsSize.negativeMainIndent)
		])
	}
}
