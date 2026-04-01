//
//  SceneDelegate.swift
//  SwiftStudyProject
//
//  Created by Rodion Blyshchak on 06.10.2025.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

	var window: UIWindow?


	func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
		guard let scene = (scene as? UIWindowScene) else { return }
//		let mainVeloceViewController = MainVeloceViewController()
//		let navigationController = UINavigationController(rootViewController: mainVeloceViewController)
//		let window = UIWindow(windowScene: scene)
//		window.rootViewController = navigationController
//		window.makeKeyAndVisible()
//				
//		self.window = window
		
		self.window = UIWindow(windowScene: scene)
		window?.rootViewController = TabBarController()
		window?.makeKeyAndVisible()
	}

	func sceneDidDisconnect(_ scene: UIScene) {
		print(#function, "Додаток повністю вимкнений")
		// Метод спрацьовує лише коли із активного додатку відкрили меню багатозадачності та завершили його
		// Якщо ж додаток згорнути, а потім відкрити багатозадачність та завершили його, метод не спрацює
	}

	func sceneDidBecomeActive(_ scene: UIScene) {
		print(#function, "Передній план додатку повністю загружений")
	}

	func sceneWillResignActive(_ scene: UIScene) {
		print(#function, "Метод спрацьовує коли додаток відкриваємо меню багатозадочності")
	}

	func sceneWillEnterForeground(_ scene: UIScene) {
		print(#function, "Викликається коли додаток переходить із фону на передній план або коли його тільки відкривають")
	}

	func sceneDidEnterBackground(_ scene: UIScene) {
		print(#function, "Фоновий режим")
	}


}

