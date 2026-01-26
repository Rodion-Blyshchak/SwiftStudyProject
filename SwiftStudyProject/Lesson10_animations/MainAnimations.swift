//
//  MainAnimations.swift
//  SwiftStudyProject
//
//  Created by Rodion Blyshchak on 24.01.2026.
//

import UIKit

class MainAnimations: UIViewController {
	//MARK: - Properties
	private var offset: CGPoint?
	
	private lazy var imageCarView: UIImageView = {
		let imageView = UIImageView()
		imageView.translatesAutoresizingMaskIntoConstraints = false
		imageView.isUserInteractionEnabled = true
		imageView.heightAnchor.constraint(equalToConstant: 200).isActive = true
//		imageView.widthAnchor.constraint(equalToConstant: 200).isActive = true
		let icon = UIImage.carF1.withRenderingMode(.alwaysTemplate)
		imageView.image = icon
		imageView.tintColor = .appBlack
		return imageView
	}()
	
	private lazy var addCarButton: UIButton = {
		let button = UIButton()
		button.translatesAutoresizingMaskIntoConstraints = false
		button.heightAnchor.constraint(equalToConstant: 50).isActive = true
		button.layer.cornerRadius = 14
		button.setTitleColor(.white, for: .normal)
		button.backgroundColor = .appBlack
		button.setTitle("Add", for: .normal)
		button.setTitleColor(.appWhite, for: .normal)
		button.titleLabel?.font = .systemFont(ofSize: 18, weight: .bold)
		button.addTarget(self, action: #selector(addCarAction), for: .touchUpInside)
		return	button
	}()
	
	//MARK: - Lifecycle
	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = .appWhite
		view.addSubview(imageCarView)
		imageCarView.alpha = 0
		
		setupButton()
		setupImageView()
	}
	
	//MARK: - Animate func
	@objc private func addCarAction() {
		UIView.animate(withDuration: 0.3) {
			self.imageCarView.alpha = 1
			let randomX = CGFloat.random(in: 20...(self.view.bounds.width - 100))
			let randomY = CGFloat.random(in: 20...(self.view.bounds.height - 100))
			
			self.imageCarView.center = CGPoint(x: randomX, y: randomY)
		}
	}
	
	// Ефект скролу
	@objc private func didSwipe() {
		UIView.animate(withDuration: 0.3, animations: {
			self.imageCarView.tintColor = [.red, .blue, .cyan, .darkGray, .green, .orange].randomElement()
		})
	}
	
	// Ефект натиску
	@objc private func handleSingleTap() {
		UIView.animate(withDuration: 0.3) {
			self.imageCarView.transform = self.imageCarView.transform.rotated(by: .pi / 2)
		}
	}
	
	@objc private func handleTripleTap() {
		UIView.animate(withDuration: 0.5, animations: {
			self.imageCarView.transform = CGAffineTransform(scaleX: 0.01, y: 0.01)
			self.imageCarView.alpha = 0
		}) { _ in
			self.imageCarView.removeFromSuperview()
		}
	}
	
	// Ефект перетягування
	@objc private func handleLongPress(_ gestureRecognizer: UILongPressGestureRecognizer) {
		let location = gestureRecognizer.location(in: view)
		
		switch gestureRecognizer.state {
		case.began:
			let locationView = gestureRecognizer.location(in: imageCarView)
			offset = locationView
			
			UIView.animate(withDuration: 0.3, animations: {
				self.imageCarView.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
				self.imageCarView.alpha = 0.6
			})
			
		case.changed:
			guard let offset = offset else { return }
			
			imageCarView.center = CGPoint(
				x: location.x + (imageCarView.bounds.midX - offset.x),
				y: location.y + (imageCarView.bounds.midY - offset.y)
			)
			
		case.ended:
			offset = nil
			
			UIView.animate(withDuration: 0.3, animations: {
				self.imageCarView.transform = .identity
				self.imageCarView.alpha = 1
			})
			
		default:
			break
		}
		
	}
	
	//MARK: - Setup func
	private func setupButton() {
		view.addSubview(addCarButton)
		
		NSLayoutConstraint.activate([
			addCarButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
			addCarButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
			addCarButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
		])
	}
	
	private func setupImageView() {
		view.addSubview(imageCarView)
		// Swipe
		let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(didSwipe))
		swipeRight.direction = .right
		imageCarView.addGestureRecognizer(swipeRight)
		
		let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(didSwipe))
		swipeLeft.direction = .left
		imageCarView.addGestureRecognizer(swipeLeft)
		
		// Tap
		let tripleTap = UITapGestureRecognizer(target: self, action: #selector(handleTripleTap))
		tripleTap.numberOfTapsRequired = 3
		imageCarView.addGestureRecognizer(tripleTap)
		
		let singleTap = UITapGestureRecognizer(target: self, action: #selector(handleSingleTap))
		singleTap.numberOfTapsRequired = 1
	
		singleTap.require(toFail: tripleTap)
		imageCarView.addGestureRecognizer(singleTap)
		
		// Drag and drop
		let longPress = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress(_:)))
		longPress.minimumPressDuration = 0.8
		imageCarView.addGestureRecognizer(longPress)
	}
}



/*
 touchesBegan: Спрацьовує в момент, коли палець торкнувся екрана. Тут ми розуміємо, що саме ми схопили.

 touchesMoved: Працює безперервно, поки ти ведеш пальцем по склу. Тут ми оновлюємо координати.

 touchesEnded: Спрацьовує, коли ти відірвав палець. Тут ми завершуємо анімацію або "кидаємо" об'єкт.

 touchesCancelled: Спрацьовує рідко (наприклад, якщо під час перетягування тобі хтось зателефонував).
 */
