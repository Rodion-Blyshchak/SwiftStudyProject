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
	
	private var baseProvider = Base()
	private lazy var dataCars: [CarModel] = baseProvider.baseCar
	
	private lazy var listCellModel: [CollectionViewCellModel] = dataCars.map { model in
		CollectionViewCellModel(
			id: model.id,
			image: model.image,
			title: model.name,
			subTitle: model.team
		)
	}

	private let searchController = UISearchBar()
	private lazy var filterListCollectionCell: [CollectionViewCellModel] = listCellModel
	
	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = .appWhite
		navigationController?.setNavigationBarHidden(true, animated: false)
		filterListCollectionCell = listCellModel
		
		setupHeader()
		setupSearch()
		setupCollection()
	}
	
	//MARK: - Header
	private let titleLable: UILabel = {
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
	
	private let subTitleLable: UILabel = {
		let subTitle = UILabel()
		subTitle.translatesAutoresizingMaskIntoConstraints = false
		subTitle.textColor = .appGreyDark
		subTitle.font = .systemFont(ofSize: ConstantsSize.fontSubTitle, weight: .light)
		let subTitleText = "Heritage collection"
		subTitle.text = subTitleText.uppercased()
		return subTitle
	}()
	
	private let stackTitleView: UIStackView = {
		let stack = UIStackView()
		stack.translatesAutoresizingMaskIntoConstraints = false
		stack.axis = .vertical
		stack.spacing = 4
		return stack
	}()
	
	private func setupHeader() {
		stackTitleView.addArrangedSubview(titleLable)
		stackTitleView.addArrangedSubview(subTitleLable)
		view.addSubview(stackTitleView)
		
		NSLayoutConstraint.activate([
			stackTitleView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
			stackTitleView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: ConstantsSize.mainIndent)
		])
		
		let userButton = UIButton()
		let buttonImage = UIImage(named: "User")?.withRenderingMode(.alwaysTemplate)
		userButton.setImage(buttonImage, for: .normal)
		userButton.tintColor = .appBlack
		userButton.translatesAutoresizingMaskIntoConstraints = false
		userButton.widthAnchor.constraint(equalToConstant: ConstantsSize.imageWidthAnchor).isActive = true
		userButton.heightAnchor.constraint(equalToConstant: ConstantsSize.imageHeightAnchor).isActive = true
		userButton.layer.cornerRadius = ConstantsSize.cornerRadius
		userButton.layer.borderWidth = 1.0
		userButton.layer.borderColor = UIColor(named: "appGreyDark")?.cgColor
		view.addSubview(userButton)
		
		NSLayoutConstraint.activate([
			userButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: ConstantsSize.mainIndent),
			userButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: ConstantsSize.negativeMainIndent)
		])
	}
	
	//MARK: - Search
	private lazy var searchView: UISearchBar = {
		let search = searchController
		search.translatesAutoresizingMaskIntoConstraints = false
		search.placeholder = "Search"
		search.searchBarStyle = .minimal
		return search
	}()
	
	private func setupSearch() {
		searchView.delegate = self
		view.addSubview(searchView)
		
		NSLayoutConstraint.activate([
			searchView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
			searchView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: ConstantsSize.mainIndent),
			searchView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: ConstantsSize.negativeMainIndent)
		])
	}
	
	private func filterSearchController(with searchText: String) {
		guard !searchText.isEmpty else {
			filterListCollectionCell = listCellModel
			layotCollectionView.reloadData()
			return
		}
		
		// title subtitle
		filterListCollectionCell = listCellModel.filter { item in
			return item.title.lowercased().contains(searchText.lowercased()) || item.subTitle.lowercased().contains(searchText.lowercased())
		}
		
		layotCollectionView.reloadData()
	}
	
	//MARK: - Collection
	private let layotCollectionView: UICollectionView = {
		let layot = UICollectionViewFlowLayout()
		layot.scrollDirection = .vertical
		layot.estimatedItemSize = .zero
		layot.minimumLineSpacing = ConstantsSize.mainIndent
		let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layot)
		collectionView.translatesAutoresizingMaskIntoConstraints = false
		return collectionView
	}()
	
	private func setupCollection() {
		view.addSubview(layotCollectionView)
		layotCollectionView.dataSource = self
		layotCollectionView.delegate = self
		layotCollectionView.register(CollectionCell.self, forCellWithReuseIdentifier: CollectionCell.reuseId)
		
		NSLayoutConstraint.activate([
			layotCollectionView.topAnchor.constraint(equalTo: stackTitleView.bottomAnchor, constant: ConstantsSize.mainIndent),
			layotCollectionView.bottomAnchor.constraint(equalTo: searchView.topAnchor),
			layotCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: ConstantsSize.negativeMainIndent),
			layotCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: ConstantsSize.mainIndent)
		])
	}
}

//MARK: - Extension
extension MainVeloceViewController: UICollectionViewDataSource {
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		filterListCollectionCell.count
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionCell.reuseId, for: indexPath) as? CollectionCell else { return UICollectionViewCell() }
		let itemData = filterListCollectionCell [indexPath.item]
		cell.configure(with: itemData)
		return cell
	}
}

extension MainVeloceViewController: UICollectionViewDelegate {
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		let select = filterListCollectionCell [indexPath.item]
		guard let fullCarModel = dataCars.first(where: { $0.id == select.id }) else { return }
		
		let detailModel = DetailViewControllerModel(
			id: fullCarModel.id,
			image: fullCarModel.image,
			title: fullCarModel.name,
			subTitle: fullCarModel.team,
			description: fullCarModel.description
		)

		let DescriptionCellVeloceViewController = DescriptionCellVeloceViewController()
		DescriptionCellVeloceViewController.data = detailModel
		navigationController?.pushViewController(DescriptionCellVeloceViewController, animated: true)
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
}
