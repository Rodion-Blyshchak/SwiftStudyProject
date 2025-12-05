//
//  StoryboardTableViewCell.swift
//  SwiftStudyProject
//
//  Created by Rodion Blyshchak on 05.12.2025.
//

import UIKit

class StoryboardTableViewCell: UITableViewCell {
	@IBOutlet weak var imageBackgroundView: UIImageView!
	@IBOutlet weak var lableTask: UILabel!

	required init?(coder: NSCoder) {
		super.init(coder: coder)
	}
	
	func configureLableText(with text: String) {
		lableTask.text = text
	}
}
