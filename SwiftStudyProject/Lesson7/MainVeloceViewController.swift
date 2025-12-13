//
//  MainVeloceViewController.swift
//  SwiftStudyProject
//
//  Created by Rodion Blyshchak on 08.12.2025.
//

import UIKit


class MainVeloceViewController: UIViewController {
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
	
	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = .appWhite
		
		setupHeader()
		setupCollection()
	}
	
	//MARK: - Header
	private func setupHeader() {
		let title = UILabel()
		title.translatesAutoresizingMaskIntoConstraints = false
		title.textColor = .appBlack
		title.font = .systemFont(ofSize: 32, weight: .bold)
		var incline = CGAffineTransform.identity
		incline.c = -0.25
		title.transform = incline
		title.text = "VELOCE"
		view.addSubview(title)
		
		NSLayoutConstraint.activate([
			title.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
			title.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16)
		])
		
		let subTitle = UILabel()
		subTitle.translatesAutoresizingMaskIntoConstraints = false
		subTitle.textColor = .appGreyDark
		subTitle.font = .systemFont(ofSize: 16, weight: .light)
		let subTitleText = "Heritage collection"
		subTitle.text = subTitleText.uppercased()
		view.addSubview(subTitle)
		
		NSLayoutConstraint.activate([
			subTitle.bottomAnchor.constraint(equalTo: title.bottomAnchor, constant: 16),
			subTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16)
		])
		
		let userButton = UIButton()
		let buttonImage = UIImage(named: "User")?.withRenderingMode(.alwaysTemplate)
		userButton.setImage(buttonImage, for: .normal)
		userButton.tintColor = .appBlack
		userButton.translatesAutoresizingMaskIntoConstraints = false
		userButton.widthAnchor.constraint(equalToConstant: 40).isActive = true
		userButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
		userButton.layer.cornerRadius = 20
		userButton.layer.borderWidth = 1.0
		userButton.layer.borderColor = UIColor(named: "appGreyDark")?.cgColor
		view.addSubview(userButton)
		
		NSLayoutConstraint.activate([
			userButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
			userButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
		])
	}
	
	//MARK: - Collection
	
	private func setupCollection() {
		let layot = UICollectionViewFlowLayout()
		layot.scrollDirection = .vertical
//		layot.itemSize = .init(width: 180, height: 180)
		layot.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
		layot.minimumLineSpacing = 16
		layot.minimumInteritemSpacing = 16
		let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layot)
		collectionView.translatesAutoresizingMaskIntoConstraints = false
		view.addSubview(collectionView)
		
		collectionView.dataSource = self
		collectionView.register(CollectionCell.self, forCellWithReuseIdentifier: CollectionCell.reuseId)
		
		NSLayoutConstraint.activate([
			collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 80),
			collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
			collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
			collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16)
		])
	}
}

//MARK: - Extension
extension MainVeloceViewController: UICollectionViewDataSource {
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		listCollectionCell.count
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionCell.reuseId, for: indexPath) as? CollectionCell else { return UICollectionViewCell() }
		let itemData = listCollectionCell[indexPath.item]
		cell.configure(with: itemData)
		return cell
	}
}
