//
//  StoryboardViewController.swift
//  SwiftStudyProject
//
//  Created by Rodion Blyshchak on 06.11.2025.
//

import UIKit

class StoryboardViewController: UIViewController {
	@IBOutlet weak var iconBacgroundDot: UIImageView!
	@IBOutlet weak var newTask: UIStackView!
	@IBOutlet weak var textField: UITextField!
	
	override func viewDidLoad() {
		super.viewDidLoad()

		if let imageView = iconBacgroundDot {
			imageView.transform = CGAffineTransform(rotationAngle: .pi)
		}
		
		// Main logic
//		iatemTasklabel.text = "text"
	}
	
	@IBAction func addNewTaskButton(_ sender: Any) {
	}
	
}
