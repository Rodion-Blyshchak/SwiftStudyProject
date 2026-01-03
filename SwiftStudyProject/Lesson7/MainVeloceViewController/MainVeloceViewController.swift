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
			weight: 798
		),
		CarModel(
			id: "1welkmddcs",
			image: UIImage(named: "Ferrari SF-24") ?? UIImage(systemName: "car.fill")!,
			name: "SF-24",
			team: "Scuderia Ferrari",
			description: "The SF-24 is designed to be a significant departure from its predecessor, featuring a completely redesigned chassis and aerodynamic package. The focus was on making the car more consistent and easier to handle across different tracks and tyre compounds.",
			maxSpeed: 345,
			acceleration: 2.4,
			weight: 798
		),
		CarModel(
			id: "dsfs",
			image: UIImage(named: "Mercedes W15") ?? UIImage(systemName: "car.fill")!,
			name: "W15",
			team: "Mercedes-AMG PETRONAS",
			description: "The W15 marks a return to a more conventional design philosophy after the team struggled with the zero sidepod concept. It features a new chassis and revised gearbox casing, aiming to establish a more stable foundation for aerodynamic development throughout the season.",
			maxSpeed: 347,
			acceleration: 2.4,
			weight: 798
		),
		CarModel(
			id: "324fdswfd",
			image: UIImage(named: "McLaren MCL38") ?? UIImage(systemName: "car.fill")!,
			name: "MCL38",
			team: "McLaren Formula 1 Team",
			description: "The MCL38 is a refinement of the aggressive upgrade package introduced mid-season last year. The focus is on improving low-speed corner performance and optimizing the cooling systems for sustained high performance.",
			maxSpeed: 342,
			acceleration: 2.5,
			weight: 798
		),
		CarModel(
			id: "dv",
			image: UIImage(named: "Alpine A524") ?? UIImage(systemName: "car.fill")!,
			name: "A524",
			team: "Alpine F1 Team",
			description: "The A524 features a new chassis and suspension layout aimed at providing a wider operating window for the car's aerodynamics. It represents a long-term development push to return to the front of the midfield.",
			maxSpeed: 338,
			acceleration: 2.6,
			weight: 798
		)
	]
	
	//MARK: - Properties
	private lazy var dataCars: [CarModel] = baseCar
	
	private lazy var listCellModel: [CollectionViewCellViewModel] = MainViewControllerViewModel(dataCars: baseCar).items
	
	private lazy var searchController = UISearchBar()
	private lazy var filterDataCars: [CollectionViewCellViewModel] = listCellModel
	
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
		stack.spacing = 4
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
		
		setupHeaderView()
		setupSearchView()
		setupCollectionView()
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
		view.addSubview(stackTitleView)
		
		NSLayoutConstraint.activate([
			stackTitleView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
			stackTitleView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: ConstantsSize.mainIndent)
		])
		
		let createNewCardButton = UIButton()
		let buttonImage = UIImage(named: "addButton")?.withRenderingMode(.alwaysTemplate)
		createNewCardButton.setImage(buttonImage, for: .normal)
		createNewCardButton.tintColor = .appBlack
		createNewCardButton.translatesAutoresizingMaskIntoConstraints = false
		createNewCardButton.widthAnchor.constraint(equalToConstant: ConstantsSize.imageWidthAnchor).isActive = true
		createNewCardButton.heightAnchor.constraint(equalToConstant: ConstantsSize.imageHeightAnchor).isActive = true
		createNewCardButton.layer.cornerRadius = ConstantsSize.cornerRadius
		createNewCardButton.layer.borderWidth = 1.0
		createNewCardButton.layer.borderColor = UIColor(named: "appGreyDark")?.cgColor
		createNewCardButton.addTarget(self, action: #selector(addNewCrad), for: .touchUpInside)
		view.addSubview(createNewCardButton)
		
		NSLayoutConstraint.activate([
			createNewCardButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: ConstantsSize.mainIndent),
			createNewCardButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: ConstantsSize.negativeMainIndent)
		])
	}
	
	private func setupSearchView() {
		searchView.delegate = self
		view.addSubview(searchView)
		
		NSLayoutConstraint.activate([
			searchView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
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

		let descriptionCellVeloceViewController = DescriptionCellVeloceViewController()
		descriptionCellVeloceViewController.viewModel = detailModel
		navigationController?.pushViewController(descriptionCellVeloceViewController, animated: true)
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
		let detailModel = CollectionViewCellViewModel(
			id: car.id,
			image: car.image,
			title: car.name,
			subTitle: car.team
		)
		
		self.dataCars.append(car)
		self.listCellModel.append(detailModel)
		self.filterDataCars = listCellModel
		self.layoutView.reloadData()
	}
}
