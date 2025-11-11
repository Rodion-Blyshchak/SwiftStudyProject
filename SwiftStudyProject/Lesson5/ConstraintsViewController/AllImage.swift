//
//  AllImage.swift
//  SwiftStudyProject
//
//  Created by Rodion Blyshchak on 09.11.2025.
//

import UIKit

class AllImage{
	static let shared = AllImage()
	
	func imageDot(to parentView: UIView, name imageName: String) {
		let imageView = UIImageView()
		imageView.image = UIImage(named: imageName)
		imageView.translatesAutoresizingMaskIntoConstraints = false
		imageView.heightAnchor.constraint(equalToConstant: 180).isActive = true
		imageView.transform = CGAffineTransform(rotationAngle: .pi)
		imageView.contentMode = .scaleAspectFill
		parentView.addSubview(imageView)
		
		NSLayoutConstraint.activate([
			imageView.leadingAnchor.constraint(equalTo: parentView.leadingAnchor),
			imageView.trailingAnchor.constraint(equalTo: parentView.trailingAnchor)
		])
	}
	
	func imageWavyContour(to parentView: UIView, name imageName: String) {
		let imageView = UIImageView()
		imageView.image = UIImage(named: imageName)
		imageView.translatesAutoresizingMaskIntoConstraints = false
		imageView.heightAnchor.constraint(equalToConstant: 250).isActive = true
		imageView.widthAnchor.constraint(equalToConstant: 250).isActive = true
		imageView.contentMode = .scaleAspectFill
		parentView.addSubview(imageView)
		
		NSLayoutConstraint.activate([
			imageView.trailingAnchor.constraint(equalTo: parentView.trailingAnchor, constant: 80),
			imageView.topAnchor.constraint(equalTo: parentView.topAnchor, constant: 280)
		])
	}
		
	func imageIntertwine(to parentView: UIView, name imageName: String) {
		let imageView = UIImageView()
		imageView.image = UIImage(named: imageName)
		imageView.translatesAutoresizingMaskIntoConstraints = false
		imageView.heightAnchor.constraint(equalToConstant: 220).isActive = true
		imageView.widthAnchor.constraint(equalToConstant: 220).isActive = true
		imageView.transform = CGAffineTransform(rotationAngle: 145 * .pi / 180.0)
		imageView.contentMode = .scaleAspectFill
		parentView.addSubview(imageView)
		
		NSLayoutConstraint.activate([
			imageView.leadingAnchor.constraint(equalTo: parentView.leadingAnchor, constant: -60),
			imageView.bottomAnchor.constraint(equalTo: parentView.bottomAnchor, constant: -110)
		])
	}
}
