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
		static let mainIndent: CGFloat = 16
		static let negativeMainIndent: CGFloat = -16
		static let fontTitle: CGFloat = 32
		static let fontSubTitle: CGFloat = 16
		static let cornerRadius: CGFloat = 20
	}
	
	private let commonImage: UIImage = {
		let imageCell = "Neon orange glasses on silhouette profile"
		if let image = UIImage(named: imageCell) {
			return image
		} else {
			return UIImage(systemName: "photo.fill") ?? UIImage()
		}
	}()
	
	private lazy var listCollectionCell: [CollectionCellStruct] = [
		CollectionCellStruct(image: self.commonImage, title: "RB20", subtitle: "Red Bull Racing"),
		CollectionCellStruct(image: self.commonImage, title: "SF-24", subtitle: "Scuderia Ferrari"),
		CollectionCellStruct(image: self.commonImage, title: "W15", subtitle: "Mercedes-AMG PETRONAS"),
		CollectionCellStruct(image: self.commonImage, title: "MCL38", subtitle: "McLaren Formula 1 Team"),
		CollectionCellStruct(image: self.commonImage, title: "A524", subtitle: "Alpine F1 Team")
		
	]

	let searchController = UISearchController(searchResultsController: nil)
	var filterListCollectionCell: [CollectionCellStruct] = []
	
	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = .appWhite
		navigationController?.setNavigationBarHidden(true, animated: false)
		filterListCollectionCell = listCollectionCell
		searchController.searchResultsUpdater = self
		navigationItem.searchController = searchController
		
		setupHeader()
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
	private func filterSearchController(with searchText: String) {
		guard !searchText.isEmpty else {
			filterListCollectionCell = listCollectionCell
			layotCollectionView.reloadData()
			return
		}
		
		// Поправити регістр!
		// title subtitle
		filterListCollectionCell = listCollectionCell.filter { item in
			return item.title.contains(searchText.lowercased()) || item.subtitle.contains(searchText.lowercased())
		}
		
		layotCollectionView.reloadData()
	}
	
	//MARK: - Collection
	private let layotCollectionView: UICollectionView = {
		let layot = UICollectionViewFlowLayout()
		layot.scrollDirection = .vertical
		layot.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
		layot.minimumLineSpacing = ConstantsSize.mainIndent
		layot.minimumInteritemSpacing = ConstantsSize.mainIndent
		let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layot)
		collectionView.translatesAutoresizingMaskIntoConstraints = false
		return collectionView
	}()
	
	private func setupCollection() {
		view.addSubview(layotCollectionView)
		layotCollectionView.dataSource = self
		layotCollectionView.register(CollectionCell.self, forCellWithReuseIdentifier: CollectionCell.reuseId)
		
		NSLayoutConstraint.activate([
			layotCollectionView.topAnchor.constraint(equalTo: stackTitleView.bottomAnchor, constant: ConstantsSize.mainIndent),
			layotCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
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

extension MainVeloceViewController: UISearchResultsUpdating {
	func updateSearchResults(for searchController: UISearchController) {
		filterSearchController(with: searchController.searchBar.text ?? "")
	}
}
