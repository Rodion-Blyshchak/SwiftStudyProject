//
//  ViewController.swift
//  SwiftStudyProject
//
//  Created by Rodion Blyshchak on 06.10.2025.
//

import UIKit

class ViewController: UIViewController {
	private var mainVeloceViewController = NewTaskInputView()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		//	ViewLesson1.shared.getRandomValue()
		//	ViewLesson2.shared.studentAndClassResults()
		//	ViewLesson3.shared.vehicleSimulatorAndStatics()
		//	ViewLesson4.shared.start()

		setupMainView()
	}
	
	private func setupMainView() {
		view.addSubview(mainVeloceViewController)
		mainVeloceViewController.translatesAutoresizingMaskIntoConstraints = false
		mainVeloceViewController.backgroundColor = .appGreen
		
		NSLayoutConstraint.activate([
			mainVeloceViewController.topAnchor.constraint(equalTo: view.topAnchor),
			mainVeloceViewController.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			mainVeloceViewController.trailingAnchor.constraint(equalTo: view.trailingAnchor),
			mainVeloceViewController.bottomAnchor.constraint(equalTo: view.bottomAnchor)
		])
	}
	
//	@IBAction func StoryboardViewController(_ sender: Any) {
//		let storyboard = UIStoryboard(name: "StoryboardTableViewController", bundle: nil)
//		let viewController = storyboard.instantiateViewController(identifier: "StoryboardTableViewController") as! StoryboardTableViewController
//		navigationController?.pushViewController(viewController, animated: true)
//	}
//	
//	@IBAction func ConstrainsViewController(_ sender: Any) {
//		let viewController = ConstraintsTableViewController()
//		navigationController?.pushViewController(viewController, animated: true)
//	}
	
}
