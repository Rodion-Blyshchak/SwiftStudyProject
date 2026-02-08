//
//  MainVeloceViewController.swift
//  SwiftStudyProject
//
//  Created by Rodion Blyshchak on 08.12.2025.
//

import UIKit


class MainVeloceViewController: UIViewController {
	enum ConstantsSize {
		static let imageHeightAnchor: CGFloat = 40
		static let imageWidthAnchor: CGFloat = 40
		static let mainIndent: CGFloat = 14
		static let negativeMainIndent: CGFloat = -14
		static let fontTitle: CGFloat = 32
		static let fontSubTitle: CGFloat = 16
		static let cornerRadius: CGFloat = imageWidthAnchor / 2
		static let spacing: CGFloat = 4
	}
	
	lazy var baseCar: [CarModel] = [
		CarModel(
			id: "1welkmcs",
			image: UIImage(named: "Red Bull RB20") ?? UIImage(systemName: "car.fill")!,
			name: "RB20",
			team: "Red Bull Racing",
			description: "The RB20 represents an evolution of its dominant predecessor, featuring aggressive sidepod and engine cover changes aimed at maximizing ground effect efficiency and top speed. It retains the philosophy of minimizing aerodynamic drag while providing exceptional stability.",
			maxSpeed: 348,
			acceleration: 2.3,
			weight: 798,
			isInFavorite: false,
			
		),
		CarModel(
			id: "1welkmddcs",
			image: UIImage(named: "Ferrari SF-24") ?? UIImage(systemName: "car.fill")!,
			name: "SF-24",
			team: "Scuderia Ferrari",
			description: "The SF-24 is designed to be a significant departure from its predecessor, featuring a completely redesigned chassis and aerodynamic package. The focus was on making the car more consistent and easier to handle across different tracks and tyre compounds.",
			maxSpeed: 345,
			acceleration: 2.4,
			weight: 798,
			isInFavorite: false,
		),
		CarModel(
			id: "dsfs",
			image: UIImage(named: "Mercedes W15") ?? UIImage(systemName: "car.fill")!,
			name: "W15",
			team: "Mercedes-AMG PETRONAS",
			description: "The W15 marks a return to a more conventional design philosophy after the team struggled with the zero sidepod concept. It features a new chassis and revised gearbox casing, aiming to establish a more stable foundation for aerodynamic development throughout the season.",
			maxSpeed: 347,
			acceleration: 2.4,
			weight: 798,
			isInFavorite: false,
		),
		CarModel(
			id: "324fdswfd",
			image: UIImage(named: "McLaren MCL38") ?? UIImage(systemName: "car.fill")!,
			name: "MCL38",
			team: "McLaren Formula 1 Team",
			description: "The MCL38 is a refinement of the aggressive upgrade package introduced mid-season last year. The focus is on improving low-speed corner performance and optimizing the cooling systems for sustained high performance.",
			maxSpeed: 342,
			acceleration: 2.5,
			weight: 798,
			isInFavorite: false,
		),
		CarModel(
			id: "dv",
			image: UIImage(named: "Alpine A524") ?? UIImage(systemName: "car.fill")!,
			name: "A524",
			team: "Alpine F1 Team",
			description: "The A524 features a new chassis and suspension layout aimed at providing a wider operating window for the car's aerodynamics. It represents a long-term development push to return to the front of the midfield.",
			maxSpeed: 338,
			acceleration: 2.6,
			weight: 798,
			isInFavorite: false,
		)
	]
	
	//MARK: - Properties
	private lazy var dataCars: [CarModel] = baseCar
	
	private lazy var listCellModel: [CollectionViewCellViewModel] = MainViewControllerViewModel(dataCars: baseCar).items
	
	private lazy var searchController = UISearchBar()
	private lazy var filterDataCars: [CollectionViewCellViewModel] = listCellModel
	private var searchViewBottomConstraint: NSLayoutConstraint?
	
	private let notificationManager = NotificationManager()
	
//	private let storageManager = CarStorageManager()
	private let coreDataManager = CoreDataManager.shared
	private lazy var isFavoriteFilterActive = false
	
	private lazy var Label: UILabel = {
		let title = UILabel()
		title.translatesAutoresizingMaskIntoConstraints = false
		title.textColor = .appBlack
		title.font = .systemFont(ofSize: ConstantsSize.fontTitle, weight: .bold)
		var incline = CGAffineTransform.identity
		incline.c = -0.25
		title.transform = incline
		title.text = "VELOCE"
		return title
	}()
	
	private lazy var subTitleLabel: UILabel = {
		let subTitle = UILabel()
		subTitle.translatesAutoresizingMaskIntoConstraints = false
		subTitle.textColor = .appGreyDark
		subTitle.font = .systemFont(ofSize: ConstantsSize.fontSubTitle, weight: .light)
		let subTitleText = "Heritage collection"
		subTitle.text = subTitleText.uppercased()
		return subTitle
	}()
	
	private lazy var stackTitleView: UIStackView = {
		let stack = UIStackView()
		stack.translatesAutoresizingMaskIntoConstraints = false
		stack.axis = .vertical
		stack.spacing = ConstantsSize.spacing
		return stack
	}()
	
	private lazy var favoriteFilterButton = UIButton()
	private lazy var createNewCardButton = UIButton()
	
	private lazy var stackButtonView: UIStackView = {
		let stack = UIStackView()
		stack.translatesAutoresizingMaskIntoConstraints = false
		stack.axis = .horizontal
		stack.spacing = ConstantsSize.mainIndent
		return stack
	}()
	
	private lazy var stackHeaderView: UIStackView = {
		let stack = UIStackView()
		stack.translatesAutoresizingMaskIntoConstraints = false
		stack.axis = .horizontal
		stack.spacing = ConstantsSize.spacing
		stack.distribution = .equalSpacing
		stack.alignment = .center
		return stack
	}()
	
	private lazy var searchView: UISearchBar = {
		let search = searchController
		search.translatesAutoresizingMaskIntoConstraints = false
		search.placeholder = "Search"
		search.searchBarStyle = .minimal
		return search
	}()
	
	private lazy var layoutView: UICollectionView = {
		let layot = UICollectionViewFlowLayout()
		layot.scrollDirection = .vertical
		layot.estimatedItemSize = .zero
		layot.minimumLineSpacing = ConstantsSize.mainIndent
		let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layot)
		collectionView.translatesAutoresizingMaskIntoConstraints = false
		return collectionView
	}()
	
	//MARK: - ViewDidLoad
	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = .appWhite
		let tapOutsideKeyboard = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
		tapOutsideKeyboard.cancelsTouchesInView = false
		view.addGestureRecognizer(tapOutsideKeyboard)
		
		navigationController?.setNavigationBarHidden(true, animated: false)
		filterDataCars = listCellModel
		
//		storageManager.delegate = self
		loadInitialData()
		setupHeaderButton()
		setupHeaderView()
		setupSearchView()
		setupCollectionView()
	}

	
	//MARK: - SetupHeaderButton
	private func setupHeaderButton() {
		[favoriteFilterButton, createNewCardButton].forEach{ button in
			button.tintColor = .appBlack
			button.translatesAutoresizingMaskIntoConstraints = false
			button.widthAnchor.constraint(equalToConstant: ConstantsSize.imageWidthAnchor).isActive = true
			button.heightAnchor.constraint(equalToConstant: ConstantsSize.imageHeightAnchor).isActive = true
			button.layer.cornerRadius = ConstantsSize.cornerRadius
			button.layer.borderWidth = 1.0
			button.layer.borderColor = UIColor(named: "appGreyDark")?.cgColor
		}
		
		
		let favoriteIcon = UIImage(systemName: "heart")?.withRenderingMode(.alwaysTemplate)
		favoriteFilterButton.setImage(favoriteIcon, for: .normal)
		favoriteFilterButton.addTarget(self, action: #selector(toggleFavoriteFilter), for: .touchUpInside)
		
		let createNewCardIcon = UIImage(named: "addButton")?.withRenderingMode(.alwaysTemplate)
		createNewCardButton.setImage(createNewCardIcon, for: .normal)
		createNewCardButton.addTarget(self, action: #selector(addNewCrad), for: .touchUpInside)
	}
	
	//MARK: - Func loadInitialData
	private func loadInitialData() {
		let saveCars = coreDataManager.fetchAllCars()
		
		if saveCars.isEmpty {
			baseCar.forEach{coreDataManager.saveCar(model: $0)}
		} else {
			self.dataCars = saveCars
		}
		
		update()
	}
	
	private func update() {
		self.listCellModel = dataCars.map {
			CollectionViewCellViewModel(id: $0.id, image: $0.image, title: $0.name, subTitle: $0.team)
		}
		self.filterDataCars = listCellModel
		self.layoutView.reloadData()
	}
	
	//MARK: - FavoriteFFilters
	@objc private func toggleFavoriteFilter() {
		isFavoriteFilterActive.toggle()
		
		let imageName = isFavoriteFilterActive ? "heart.fill" : "heart"
		favoriteFilterButton.setImage(UIImage(systemName: imageName), for: .normal)

		filterFavorites()
	}
	
	private func filterFavorites() {
		let filteredModels: [CarModel]
		
		if isFavoriteFilterActive {
			filteredModels = dataCars.filter { $0.isInFavorite }
		} else {
			filteredModels = dataCars
		}
		
		filterDataCars = filteredModels.map {
			CollectionViewCellViewModel(id: $0.id, image: $0.image, title: $0.name, subTitle: $0.team)
		}
		layoutView.reloadData()
	}
	
	//MARK: - Func addNewCrad
	@objc private func addNewCrad() {
		let addCarViewController = AddCarViewController()
		addCarViewController.delegate = self
		addCarViewController.modalPresentationStyle = .pageSheet
		self.present(addCarViewController, animated: true)
	}

	//MARK: - Func filterSearchController
	private func filterSearchController(with searchText: String) {
		guard !searchText.isEmpty else {
			filterDataCars = listCellModel
			layoutView.reloadData()
			return
		}
		// title subtitle
		filterDataCars = listCellModel.filter { item in
			return item.title.lowercased().contains(searchText.lowercased()) || item.subTitle.lowercased().contains(searchText.lowercased())
		}
		
		layoutView.reloadData()
	}
	
	//MARK: - StacksView
	private func setupHeaderView() {
		stackTitleView.addArrangedSubview(Label)
		stackTitleView.addArrangedSubview(subTitleLabel)
		
		stackButtonView.addArrangedSubview(favoriteFilterButton)
		stackButtonView.addArrangedSubview(createNewCardButton)
		
		stackHeaderView.addArrangedSubview(stackTitleView)
		stackHeaderView.addArrangedSubview(stackButtonView)
		view.addSubview(stackHeaderView)
		
		NSLayoutConstraint.activate([
			stackHeaderView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
			stackHeaderView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: ConstantsSize.mainIndent),
			stackHeaderView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: ConstantsSize.negativeMainIndent)
		])
	}
	
	private func setupSearchView() {
		searchView.delegate = self
		notificationManager.delegate = self
		view.addSubview(searchView)
		
		searchViewBottomConstraint = searchView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
		
		NSLayoutConstraint.activate([
			searchViewBottomConstraint!,
			searchView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: ConstantsSize.mainIndent),
			searchView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: ConstantsSize.negativeMainIndent)
		])
	}
	
	private func setupCollectionView() {
		view.addSubview(layoutView)
		layoutView.dataSource = self
		layoutView.delegate = self
		layoutView.register(CollectionCell.self, forCellWithReuseIdentifier: CollectionCell.reuseId)
		
		NSLayoutConstraint.activate([
			layoutView.topAnchor.constraint(equalTo: stackTitleView.bottomAnchor, constant: ConstantsSize.mainIndent),
			layoutView.bottomAnchor.constraint(equalTo: searchView.topAnchor),
			layoutView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: ConstantsSize.negativeMainIndent),
			layoutView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: ConstantsSize.mainIndent)
		])
	}
}

//MARK: - Extension
extension MainVeloceViewController: UICollectionViewDataSource {
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		filterDataCars.count
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionCell.reuseId, for: indexPath) as? CollectionCell else { return UICollectionViewCell() }
		let itemData = filterDataCars [indexPath.item]
		cell.configure(with: itemData)
		return cell
	}
}

extension MainVeloceViewController: UICollectionViewDelegate {
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		let selectedItem = filterDataCars [indexPath.item]
		guard let fullCarModel = dataCars.first(where: { $0.id == selectedItem.id }) else { return }
		
		let detailModel = DetailViewControllerViewModel(
			id: fullCarModel.id,
			image: fullCarModel.image,
			title: fullCarModel.name,
			subTitle: fullCarModel.team,
			description: fullCarModel.description
		)

		let descriptionViewController = DescriptionCellVeloceViewController()
		descriptionViewController.viewModel = detailModel
		descriptionViewController.itemID = detailModel.id
		descriptionViewController.favoriteStatus = fullCarModel.isInFavorite
		descriptionViewController.delegate = self
		
		navigationController?.pushViewController(descriptionViewController, animated: true)
	}
}

extension MainVeloceViewController: UICollectionViewDelegateFlowLayout {
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		let widthView = collectionView.bounds.width
		let spacing = ConstantsSize.mainIndent
		
		return CGSize(width: (Int(widthView) - Int(spacing)) / 2, height: 180)
	}
}

extension MainVeloceViewController: UISearchBarDelegate {
	func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
		filterSearchController(with: searchText)
	}
	
	func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
		searchBar.resignFirstResponder()
	}
}

extension MainVeloceViewController: AddCarViewDelegate {
	func didAddNewCar(car: CarModel) {
//		let detailModel = CollectionViewCellViewModel(
//			id: car.id,
//			image: car.image,
//			title: car.name,
//			subTitle: car.team
//		)
//		
//		self.dataCars.append(car)
//		self.listCellModel.append(detailModel)
//		self.filterDataCars = listCellModel
//		self.layoutView.reloadData()
		
		coreDataManager.saveCar(model: car)
		
		self.dataCars = coreDataManager.fetchAllCars()
		update()
	}
}

extension MainVeloceViewController: NotificationManagerDelegate {
	func keyboardToggle(height: CGFloat, isOn: Bool) {
		searchViewBottomConstraint?.constant = isOn ? -height + self.view.safeAreaInsets.bottom : 0
		
		UIView.animate(withDuration: 0.3) {
			self.view.layoutIfNeeded()
		}
	}
}

extension MainVeloceViewController: DescriptionCellVeloceViewControllerDelegate {
	func didTapFavoriteAction(id: String) {
		if let index = dataCars.firstIndex(where: { $0.id == id }) {
			dataCars[index].isInFavorite.toggle()
			coreDataManager.saveCar(model: dataCars[index])
			
			if let currentDetailVC = navigationController?.topViewController as? DescriptionCellVeloceViewController {
				currentDetailVC.updateFavoriteStatus(isFavorite: dataCars[index].isInFavorite)
			}
			
			if isFavoriteFilterActive {
				filterFavorites()
			}
		}
	}
}

extension MainVeloceViewController: CarStorageManagerDelegate {
	func didUpdateFavorites(list: [String]) {
		filterFavorites()
	}
}
