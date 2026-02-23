//
//  MainViewControllerViewModel.swift
//  SwiftStudyProject
//
//  Created by Rodion Blyshchak on 21.12.2025.
//

import UIKit

struct MainViewControllerViewModel {
	let items: [CollectionViewCellViewModel]
	
	init(dataCars: [CarModel]) {
		items = dataCars.map { model in
			CollectionViewCellViewModel(
				id: model.id,
				image:"",
				title: model.name,
				subTitle: model.team
			)
		}
	}
}
