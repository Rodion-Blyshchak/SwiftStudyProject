//
//  MainAnimations.swift
//  SwiftStudyProject
//
//  Created by Rodion Blyshchak on 24.01.2026.
//

import UIKit

class MainAnimationViewController: UIViewController {
	//MARK: - Properties
	private var imageCarsView: [UIImageView] = []
	private var currentImageCarView: UIImageView? {
		return imageCarsView.first
	}
	
	private var offset: CGPoint?
	private let vibrationGenerator = UIImpactFeedbackGenerator(style: .medium) // .light, .medium, .heavy, .soft, .rigid
	private var currentAngle: CGFloat = 0
	
	private lazy var rotationSlider: UISlider = {
		let slider = UISlider()
		slider.translatesAutoresizingMaskIntoConstraints = false
		slider.minimumValue = 0
		slider.maximumValue = Float.pi * 2
		slider.alpha = 0
		slider.minimumTrackTintColor = .appBlack
		slider.addTarget(self, action: #selector(sliderChanged(_:)), for: .valueChanged)
		return slider
	}()
	
	private let addCarButton: UIButton = {
		let button = UIButton()
		button.translatesAutoresizingMaskIntoConstraints = false
		button.heightAnchor.constraint(equalToConstant: 50).isActive = true
		button.layer.cornerRadius = 14
		button.setTitleColor(.white, for: .normal)
		button.backgroundColor = .appBlack
		button.setTitle("Add", for: .normal)
		button.setTitleColor(.appWhite, for: .normal)
		button.titleLabel?.font = .systemFont(ofSize: 18, weight: .bold)
		button.addTarget(self, action: #selector(didTapAddButton), for: .touchUpInside)
		return	button
	}()
	
	//MARK: - Lifecycle
	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = .appWhite
		
	
		setupButton()
		setupSlider()
		
		currentImageCarView?.alpha = 0
	}
	
	//MARK: - CreateNewImageCar func
	private func createNewImageCar() -> UIImageView {
		let imageView = UIImageView()
		imageView.translatesAutoresizingMaskIntoConstraints = false
		imageView.isUserInteractionEnabled = true
		imageView.heightAnchor.constraint(equalToConstant: 200).isActive = true
//		imageView.widthAnchor.constraint(equalToConstant: 200).isActive = true
		let icon = UIImage.carF1.withRenderingMode(.alwaysTemplate)
		imageView.image = icon
		imageView.tintColor = .appBlack
		
		setupImageView(imageView)
		return imageView
	}
	
	//MARK: - Animate func
	@objc private func didTapAddButton() {
		guard imageCarsView.isEmpty else { return }
		
		let newImageCar = createNewImageCar()
		view.addSubview(newImageCar)
		imageCarsView.append(newImageCar)
		
		UIView.animate(withDuration: 0.3) {
			newImageCar.alpha = 1
			self.rotationSlider.alpha = 1
			let randomX = CGFloat.random(in: 20...(self.view.bounds.width - 100))
			let randomY = CGFloat.random(in: 20...(self.view.bounds.height - 100))
			
			newImageCar.center = CGPoint(x: randomX, y: randomY)
		}
	}
	
	private func updateCarRotation() {
		currentImageCarView?.transform = CGAffineTransform(rotationAngle: currentAngle)
		rotationSlider.value = Float(currentAngle)
	}
	
	// Ефект скролу
	@objc private func handleSwipe() {
		UIView.animate(withDuration: 0.3, animations: {
			self.currentImageCarView?.tintColor = [.red, .blue, .cyan, .darkGray, .green, .orange].randomElement()
		})
	}
	
	// Ефект натиску
	@objc private func handleSingleTap() {
		vibrationGenerator.impactOccurred()
		
		UIView.animate(withDuration: 0.3) {
			self.currentAngle += .pi / 2
			
			if self.currentAngle >= .pi * 2 {
				self.currentAngle -= .pi * 2
			}
			
			self.updateCarRotation()
		}
	}
	
	@objc private func handleTripleTap() {
		UIView.animate(withDuration: 0.5, animations: {
			self.currentImageCarView?.transform = CGAffineTransform(scaleX: 0.01, y: 0.01)
			self.currentImageCarView?.alpha = 0
		}) { _ in
			self.currentImageCarView?.removeFromSuperview()
		}
		
		self.imageCarsView.removeAll()
	}
	
	// Slider
	@objc private func sliderChanged( _ sender: UISlider) {
		currentAngle = CGFloat(sender.value)
		currentImageCarView?.transform = CGAffineTransform(rotationAngle: currentAngle)
	}
	
	// Ефект перетягування
	@objc private func handleLongPress(_ gestureRecognizer: UILongPressGestureRecognizer) {
		let location = gestureRecognizer.location(in: view)
		
		switch gestureRecognizer.state {
		case.began:
			let locationView = gestureRecognizer.location(in: currentImageCarView)
			offset = locationView

			vibrationGenerator.impactOccurred()
			
			UIView.animate(withDuration: 0.3, animations: {
				self.currentImageCarView?.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
				self.currentImageCarView?.alpha = 0.6
			})
			
		case.changed:
			guard let offset = offset else { return }
			
			currentImageCarView?.center = CGPoint(
				x: location.x + ((currentImageCarView?.bounds.midX ?? 0) - offset.x),
				y: location.y + ((currentImageCarView?.bounds.midY ?? 0) - offset.y)
			)
			
		case.ended:
			offset = nil
			
			UIView.animate(withDuration: 0.3, animations: {
				self.updateCarRotation()
				self.currentImageCarView?.alpha = 1
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
	
	private func setupImageView(_ image: UIImageView) {
		// Swipe
		let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe))
		swipeRight.direction = .right
		image.addGestureRecognizer(swipeRight)
		
		let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe))
		swipeLeft.direction = .left
		image.addGestureRecognizer(swipeLeft)
		
		// Tap
		let tripleTap = UITapGestureRecognizer(target: self, action: #selector(handleTripleTap))
		tripleTap.numberOfTapsRequired = 3
		image.addGestureRecognizer(tripleTap)
		
		let singleTap = UITapGestureRecognizer(target: self, action: #selector(handleSingleTap))
		singleTap.numberOfTapsRequired = 1
	
		singleTap.require(toFail: tripleTap)
		image.addGestureRecognizer(singleTap)
		
		// Drag and drop
		let longPress = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress(_:)))
		longPress.minimumPressDuration = 0.8
		image.addGestureRecognizer(longPress)
	}
	
	private func setupSlider() {
		view.addSubview(rotationSlider)
		
		NSLayoutConstraint.activate([
			rotationSlider.bottomAnchor.constraint(equalTo: addCarButton.topAnchor, constant: -20),
			rotationSlider.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
			rotationSlider.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30)
		])
	}
}



/*
 touchesBegan: Спрацьовує в момент, коли палець торкнувся екрана. Тут ми розуміємо, що саме ми схопили.

 touchesMoved: Працює безперервно, поки ти ведеш пальцем по склу. Тут ми оновлюємо координати.

 touchesEnded: Спрацьовує, коли ти відірвав палець. Тут ми завершуємо анімацію або "кидаємо" об'єкт.

 touchesCancelled: Спрацьовує рідко (наприклад, якщо під час перетягування тобі хтось зателефонував).
 */
