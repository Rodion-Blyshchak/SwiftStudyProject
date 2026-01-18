//
//  NotificationKeyboard.swift
//  SwiftStudyProject
//
//  Created by Rodion Blyshchak on 09.01.2026.
//

import UIKit

protocol NotificationManagerDelegate {
	func keyboardToggle(height: CGFloat, isOn: Bool)
}

class NotificationManager {
	var delegate: NotificationManagerDelegate?
	
	init(delegate: NotificationManagerDelegate? = nil) {
		self.delegate = delegate
		activatyNotificationKeyboard()
	}
	
	private func activatyNotificationKeyboard() {
		NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
		NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
	}
	
	@objc private func keyboardWillShow(_ notification: NSNotification) {
		guard let userInfo = notification.userInfo,
			  let value = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else { return }
		
		delegate?.keyboardToggle(height: value.height, isOn: true)
	}
	
	@objc private func keyboardWillHide() {
		delegate?.keyboardToggle(height: 0, isOn: false)
	}
}
