//
//  TabBarController.swift
//  SwiftStudyProject
//
//  Created by Rodion Blyshchak on 26.03.2026.
//

import UIKit

class TabBarController: UITabBarController {
	
	override func viewDidLoad() {
		super.viewDidLoad()
		setTabs()
	}
	
	private func setTabs() {
		let mainVeloceViewController = createViewController(
			rootViewController: MainVeloceViewController(),
			title: "Veloce",
			image: .init(systemName: "car.side.fill"),
			tag: 0,
			navigationControllerRequired: true
		)
		
		let mapKitViewController = createViewController(
			rootViewController: MapKitViewController(),
			title: "Map",
			image: .init(systemName: "map.fill"),
			tag: 1,
			navigationControllerRequired: false
		)
		
		let mainAnimationViewController = createViewController(
			rootViewController: MainAnimationViewController(),
			title: "Animation",
			image: .init(systemName: "arrow.2.circlepath.circle"),
			tag: 2,
			navigationControllerRequired: false
		)
		
		setViewControllers([mainVeloceViewController, mapKitViewController, mainAnimationViewController], animated: true)
	}
	
	private func createViewController(
		rootViewController: UIViewController,
		title: String,
		image: UIImage?,
		tag: Int,
		navigationControllerRequired: Bool) -> UIViewController {
			
			let navigationController = navigationControllerRequired ? UINavigationController(rootViewController: rootViewController) : rootViewController
			
			navigationController.tabBarItem = UITabBarItem(
				title: title,
				image: image,
				tag: tag
			)
			
			return navigationController
		}
}
