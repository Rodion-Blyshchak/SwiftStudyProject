//
//  ItemTaskStoryboardView.swift
//  SwiftStudyProject
//
//  Created by Rodion Blyshchak on 23.11.2025.
//

import UIKit

class ItemTaskStoryboardView: UIView {

	@IBOutlet weak var labelText: UILabel!
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		self.configureView()
	}
	
	required init?(coder: NSCoder) {
		super.init(coder: coder)
		self.configureView()
	}
	
	private func configureView() {
		let subView = self.loadViewFromXib()
		subView.frame = self.bounds
		subView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
		self.addSubview(subView)
	}
	
	private func loadViewFromXib() -> UIView {
		guard let view = Bundle.main.loadNibNamed("ItemTaskStoryboardView", owner: self)?.first as? UIView else { return UIView() }
		return view
	}
	
	var removeTaskAction: ((Int) -> Void)?
	var taskIndex: Int = 0
	
	@IBAction func removeTaskViewAction(_ sender: Any) {
		removeTaskAction?(taskIndex)
	}
}
