//
//  CollectionCellStruct.swift
//  SwiftStudyProject
//
//  Created by Rodion Blyshchak on 13.12.2025.
//

import UIKit

struct CollectionCellStruct {
	let image: UIImage
	let title: String
	let subtitle: String
	let description: String?
	
	private static let commonImage: UIImage = {
		let imageCell = "Neon orange glasses on silhouette profile"
		if let image = UIImage(named: imageCell) {
			return image
		} else {
			return UIImage(systemName: "photo.fill") ?? UIImage()
		}
	}()
	
	static var listCollectionCell: [CollectionCellStruct] = [
		CollectionCellStruct(
			image: commonImage,
			title: "RB20",
			subtitle: "Red Bull Racing",
			description: "The RB20 represents an evolution of its dominant predecessor, featuring aggressive sidepod and engine cover changes aimed at maximizing ground effect efficiency and top speed. It retains the philosophy of minimizing aerodynamic drag while providing exceptional stability. \n\nMax Speed: 348 km/h | 0-100 kph: 2.3 s | Weight: 798 kg"
		),
		CollectionCellStruct(
			image: commonImage,
			title: "SF-24",
			subtitle: "Scuderia Ferrari",
			description: "The SF-24 is designed to be a significant departure from its predecessor, featuring a completely redesigned chassis and aerodynamic package. The focus was on making the car more consistent and easier to handle across different tracks and tyre compounds. \n\nMax Speed: 345 km/h | 0-100 kph: 2.4 s | Weight: 798 kg"
		),
		CollectionCellStruct(
			image: commonImage,
			title: "W15",
			subtitle: "Mercedes-AMG PETRONAS",
			description: "The W15 marks a return to a more conventional design philosophy after the team struggled with the zero sidepod concept. It features a new chassis and revised gearbox casing, aiming to establish a more stable foundation for aerodynamic development throughout the season. \n\nMax Speed: 347 km/h | 0-100 kph: 2.4 s | Weight: 798 kg"
		),
		CollectionCellStruct(
			image: commonImage,
			title: "MCL38",
			subtitle: "McLaren Formula 1 Team",
			description: "The MCL38 is a refinement of the aggressive upgrade package introduced mid-season last year. The focus is on improving low-speed corner performance and optimizing the cooling systems for sustained high performance. \n\nMax Speed: 342 km/h | 0-100 kph: 2.5 s | Weight: 798 kg"
		),
		CollectionCellStruct(
			image: commonImage,
			title: "A524",
			subtitle: "Alpine F1 Team",
			description: "The A524 features a new chassis and suspension layout aimed at providing a wider operating window for the car's aerodynamics. It represents a long-term development push to return to the front of the midfield. \n\nMax Speed: 338 km/h | 0-100 kph: 2.6 s | Weight: 798 kg"
		)
	]
}
