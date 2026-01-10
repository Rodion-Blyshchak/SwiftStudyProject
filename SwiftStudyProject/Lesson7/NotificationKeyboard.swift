//
//  NotificationKeyboard.swift
//  SwiftStudyProject
//
//  Created by Rodion Blyshchak on 09.01.2026.
//

import UIKit

class NotificationKeyboard {
	var onKeyboardToggle: ((_ height: CGFloat, _ isOn: Bool) -> Void)?
	
	init(onKeyboardToggle: ((_: CGFloat, _: Bool) -> Void)? = nil) {
		self.onKeyboardToggle = onKeyboardToggle
		activatyNotificationKeyboard()
	}
	
	private func activatyNotificationKeyboard() {
		NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
		NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
	}
	
	@objc private func keyboardWillShow(_ notification: NSNotification) {
		guard let userInfo = notification.userInfo,
			  let value = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else { return }
		
		let height = value.height
		onKeyboardToggle?(height, true)
	}
	
	@objc private func keyboardWillHide() {
		onKeyboardToggle?(0, false)
	}
}
