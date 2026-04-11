//
//  DescriptionCellVeloceViewController.swift
//  SwiftStudyProject
//
//  Created by Rodion Blyshchak on 15.12.2025.
//

import UIKit
import MapKit

protocol DescriptionCellVeloceViewControllerDelegate {
	func didTapFavoriteAction(id: Int)
}

class DescriptionCellVeloceViewController: UIViewController {
	enum ConstantsSize {
		static let imageHeightAnchor: CGFloat = 300
		static let buttonHeightAnchor: CGFloat = 50
		static let buttonWidthAnchor: CGFloat = 50
		static let mainIndent: CGFloat = 14
		static let negativeMainIndent: CGFloat = -14
		static let font: CGFloat = 20
		static let fontNameCar: CGFloat = 48
		static let cornerRadius: CGFloat = 20
	}
	
	//MARK: - Properties
	var viewModel: DetailViewControllerViewModel?
	var delegate: DescriptionCellVeloceViewControllerDelegate?
	var itemID: Int?
	
	private let imageView: UIImageView = {
		let image = UIImageView()
		image.translatesAutoresizingMaskIntoConstraints = false
		image.contentMode = .scaleAspectFill
		image.heightAnchor.constraint(equalToConstant: ConstantsSize.imageHeightAnchor).isActive = true
		image.clipsToBounds = true
		return image
	}()
	
	private let scrollView: UIScrollView = {
		let scroll = UIScrollView()
		scroll.translatesAutoresizingMaskIntoConstraints = false
		scroll.alwaysBounceVertical = true
		scroll.showsVerticalScrollIndicator = false
		return scroll
	}()
	
	private let contentView: UIView = {
		let content = UIView()
		content.translatesAutoresizingMaskIntoConstraints = false
		return content
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
		descriptionLabel.textColor = .appBlack
		descriptionLabel.font = .systemFont(ofSize: ConstantsSize.font, weight: .light)
		descriptionLabel.numberOfLines = 0
		return descriptionLabel
	}()
	
	private let locationLabel: UILabel = {
		let location = UILabel()
		location.translatesAutoresizingMaskIntoConstraints = false
		location.textColor = .appBlack
		location.font = .systemFont(ofSize: ConstantsSize.font, weight: .bold)
		location.text = "Searching location..."
		location.numberOfLines = 2
		return location
	}()
	
	private let geocoder = CLGeocoder()
	
	private	lazy var mapView: MKMapView = {
		let map = MKMapView()
		map.translatesAutoresizingMaskIntoConstraints = false
		map.layer.cornerRadius = ConstantsSize.cornerRadius
		return map
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
		
		UIView.animate(withDuration: 0.3) {
			self.tabBarController?.tabBar.alpha = 0
		}
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = .appWhite
		
		setupImageView()
		setupFavoriteButton()
		setupScrollView()
		setupContentView()
		
		displayCarOnMap()
		fetchCityName()
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
	
	//MARK: - Map
	private func displayCarOnMap() {
		guard let location = viewModel?.location else { return }
		
		let annotation = MKPointAnnotation()
		annotation.coordinate = CLLocationCoordinate2D(
			latitude: location.latitude,
			longitude: location.longitude
		)
		
		mapView.addAnnotation(annotation)
		mapView.showAnnotations([annotation], animated: true)
	}
	
	private func fetchCityName() {
		let location = CLLocation(latitude: viewModel?.location?.latitude ?? 0, longitude: viewModel?.location?.longitude ?? 0)
		
		location.geocode { placemark, error in
			if let error = error as? CLError {
				print("CLError:", error)
				return
			} else if let placemark = placemark?.first {
				DispatchQueue.main.async {
					self.locationLabel.text = "Location: \(placemark.locality ?? ""), \(placemark.administrativeArea ?? "")"
				}
			}
		}
	}
	
	//MARK: - Setup
	private func setupImageView() {
		view.addSubview(imageView)
		
		guard let viewModel else { return }
		
		let imageFromDatabase = UIImage(data: viewModel.imageData ?? Data())
		imageView.image = imageFromDatabase ?? UIImage(named: "Default_image")
		
		
		NSLayoutConstraint.activate([
			imageView.topAnchor.constraint(equalTo: view.topAnchor),
			imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
		])
	}
	
	private func setupScrollView() {
		view.addSubview(scrollView)
		scrollView.addSubview(contentView)
		
		NSLayoutConstraint.activate([
			scrollView.topAnchor.constraint(equalTo: imageView.bottomAnchor),
			scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
			scrollView.bottomAnchor.constraint(equalTo: favoriteButton.topAnchor, constant: ConstantsSize.negativeMainIndent),
		])
	}
	
	private func setupContentView() {
		contentView.addSubview(mainInfoStackView)
		contentView.addSubview(carDescriptionLabel)
		contentView.addSubview(locationLabel)
		contentView.addSubview(mapView)
		
		mainInfoStackView.addArrangedSubview(nameCarLabel)
		mainInfoStackView.addArrangedSubview(teamCarLabel)
		
		guard let viewModel else { return }
		nameCarLabel.text = viewModel.title
		teamCarLabel.text = viewModel.subTitle.uppercased()
		
		carDescriptionLabel.text = viewModel.description
		
		
		NSLayoutConstraint.activate([
			contentView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
			contentView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
			contentView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
			contentView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
			contentView.widthAnchor.constraint(equalTo: scrollView.frameLayoutGuide.widthAnchor),
			
			mainInfoStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: ConstantsSize.mainIndent),
			mainInfoStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: ConstantsSize.mainIndent),
			mainInfoStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: ConstantsSize.negativeMainIndent),
			
			carDescriptionLabel.topAnchor.constraint(equalTo: mainInfoStackView.bottomAnchor, constant: ConstantsSize.mainIndent),
			carDescriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: ConstantsSize.mainIndent),
			carDescriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: ConstantsSize.negativeMainIndent),
			
			locationLabel.topAnchor.constraint(equalTo: carDescriptionLabel.bottomAnchor, constant: ConstantsSize.mainIndent),
			locationLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: ConstantsSize.mainIndent),
			locationLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: ConstantsSize.negativeMainIndent),
			
			mapView.topAnchor.constraint(equalTo: locationLabel.bottomAnchor, constant: ConstantsSize.mainIndent),
			mapView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: ConstantsSize.mainIndent),
			mapView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: ConstantsSize.negativeMainIndent),
			mapView.heightAnchor.constraint(equalTo: mapView.widthAnchor, multiplier: 0.6),
			mapView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: ConstantsSize.negativeMainIndent)
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

extension CLLocation {
	func geocode(completion: @escaping (_ placemark: [CLPlacemark]?, _ error: Error?) -> Void) {
		CLGeocoder().reverseGeocodeLocation(self, completionHandler: completion)
	}
}
