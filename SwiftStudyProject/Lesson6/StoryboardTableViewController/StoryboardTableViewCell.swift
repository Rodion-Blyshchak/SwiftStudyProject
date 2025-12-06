//
//  StoryboardTableViewCell.swift
//  SwiftStudyProject
//
//  Created by Rodion Blyshchak on 05.12.2025.
//

import UIKit

class StoryboardTableViewCell: UITableViewCell {
	@IBOutlet weak var lable: UILabel!

	required init?(coder: NSCoder) {
		super.init(coder: coder)
	}
	
	func configureLableText(with text: String) {
		lable.text = text
	}
}
