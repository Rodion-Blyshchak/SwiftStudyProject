//
//  MainAnimations.swift
//  SwiftStudyProject
//
//  Created by Rodion Blyshchak on 24.01.2026.
//

import UIKit

class MainAnimationViewController: UIViewController {
	//MARK: - Properties
	private var imageCarViews: [UIImageView] = []
//	private var currentImageCarView: UIImageView? {
//		return imageCarViews.last
//	}
	private var activeCar: UIImageView?
	
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
	}
	
	//MARK: - CreateNewImageCar func
	private func createNewImageCar() -> UIImageView {
		let imageView = UIImageView()
//		imageView.translatesAutoresizingMaskIntoConstraints = false
		imageView.isUserInteractionEnabled = true
		imageView.frame = CGRect(x: 0, y: 0, width: 200, height: 200)
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
		let newImageCar = createNewImageCar()
		view.addSubview(newImageCar)
		imageCarViews.append(newImageCar)
		activeCar = newImageCar
		
		view.layoutIfNeeded()
		
		let randomX = CGFloat.random(in: 100...(view.bounds.width - 100))
		let randomY = CGFloat.random(in: 100...(view.bounds.height - 100))
		
		newImageCar.center = CGPoint(x: randomX, y: randomY)
		newImageCar.alpha = 0
		
		UIView.animate(withDuration: 0.3) {
			newImageCar.alpha = 1
			self.rotationSlider.alpha = 1
		}
		
		// Елементи будуть з найбільшим z-індексом
		view.bringSubviewToFront(addCarButton)
		view.bringSubviewToFront(rotationSlider)
	}
	
//	private func updateCarRotation(_ sender: UISwipeGestureRecognizer) {
//		currentImageCarView?.transform = CGAffineTransform(rotationAngle: currentAngle)
//		rotationSlider.value = Float(currentAngle)
//	}
	
	// Ефект скролу
	@objc private func handleSwipe(_ sender: UISwipeGestureRecognizer) {
		guard let target = sender.view as? UIImageView else { return }
		activeCar = target
		UIView.animate(withDuration: 0.3, animations: {
			target.tintColor = [.red, .blue, .cyan, .darkGray, .green, .orange].randomElement()
		})
	}
	
	// Ефект натиску
	@objc private func handleSingleTap(_ sender: UITapGestureRecognizer) {
		guard let target = sender.view as? UIImageView else { return }
		activeCar = target
		vibrationGenerator.impactOccurred()
		
		currentAngle += .pi / 2
		if currentAngle >= .pi * 2 { currentAngle -= .pi * 2 }
		
		UIView.animate(withDuration: 0.3) {
			target.transform = CGAffineTransform(rotationAngle: self.currentAngle)
			self.rotationSlider.value = Float(self.currentAngle)
		}
	}
	
	@objc private func handleTripleTap(_ sender: UISwipeGestureRecognizer) {
		guard let target = sender.view as? UIImageView else { return }
		UIView.animate(withDuration: 0.5, animations: {
			target.transform = CGAffineTransform(scaleX: 0.01, y: 0.01)
			target.alpha = 0
		}) { _ in
			target.removeFromSuperview()
			self.imageCarViews.removeAll(where: { $0 == target })
		}
	}
	
	// Slider
	@objc private func sliderChanged( _ sender: UISlider) {
		currentAngle = CGFloat(sender.value)
		activeCar?.transform = CGAffineTransform(rotationAngle: currentAngle)
	}
	
	// Ефект перетягування
	@objc private func handleLongPress(_ gestureRecognizer: UILongPressGestureRecognizer) {
		guard let targetCar = gestureRecognizer.view as? UIImageView else { return }
		let location = gestureRecognizer.location(in: view)
		
		switch gestureRecognizer.state {
		case.began:
			activeCar = targetCar
			let locationView = gestureRecognizer.location(in: targetCar)
			offset = locationView

			vibrationGenerator.impactOccurred()
			
			UIView.animate(withDuration: 0.3, animations: {
				targetCar.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
				targetCar.alpha = 0.6
			})
			
		case.changed:
			guard let offset = offset else { return }
			
			targetCar.center = CGPoint(
				x: location.x + ((targetCar.bounds.midX) - offset.x),
				y: location.y + ((targetCar.bounds.midY) - offset.y)
			)
			
		case.ended:
			offset = nil
			
			UIView.animate(withDuration: 0.3, animations: {
//				self.updateCarRotation()
				targetCar.transform = CGAffineTransform(rotationAngle: self.currentAngle)
				targetCar.alpha = 1
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
