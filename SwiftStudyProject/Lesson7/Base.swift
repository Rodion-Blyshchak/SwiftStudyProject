//
//  Base.swift
//  SwiftStudyProject
//
//  Created by Rodion Blyshchak on 20.12.2025.
//

import UIKit

struct Base {
	private let commonImage: UIImage = {
		let imageCell = "Neon orange glasses on silhouette profile"
		if let image = UIImage(named: imageCell) {
			return image
		} else {
			return UIImage(systemName: "photo.fill") ?? UIImage()
		}
	}()
	
	lazy var baseCar: [CarModel] = [
		CarModel(
			id: "1welkmcs",
			image: commonImage,
			name: "RB20",
			team: "Red Bull Racing",
			description: "The RB20 represents an evolution of its dominant predecessor, featuring aggressive sidepod and engine cover changes aimed at maximizing ground effect efficiency and top speed. It retains the philosophy of minimizing aerodynamic drag while providing exceptional stability.",
			maxSpeed: 348,
			overclockingTo100: 2.3,
			Weight: 798
		),
		CarModel(
			id: "1welkmddcs",
			image: commonImage,
			name: "SF-24",
			team: "Scuderia Ferrari",
			description: "The SF-24 is designed to be a significant departure from its predecessor, featuring a completely redesigned chassis and aerodynamic package. The focus was on making the car more consistent and easier to handle across different tracks and tyre compounds.",
			maxSpeed: 345,
			overclockingTo100: 2.4,
			Weight: 798
		),
		CarModel(
			id: "dsfs",
			image: commonImage,
			name: "W15",
			team: "Mercedes-AMG PETRONAS",
			description: "The W15 marks a return to a more conventional design philosophy after the team struggled with the zero sidepod concept. It features a new chassis and revised gearbox casing, aiming to establish a more stable foundation for aerodynamic development throughout the season.",
			maxSpeed: 347,
			overclockingTo100: 2.4,
			Weight: 798
		),
		CarModel(
			id: "324fdswfd",
			image: commonImage,
			name: "MCL38",
			team: "McLaren Formula 1 Team",
			description: "The MCL38 is a refinement of the aggressive upgrade package introduced mid-season last year. The focus is on improving low-speed corner performance and optimizing the cooling systems for sustained high performance.",
			maxSpeed: 342,
			overclockingTo100: 2.5,
			Weight: 798
		),
		CarModel(
			id: "dv",
			image: commonImage,
			name: "A524",
			team: "Alpine F1 Team",
			description: "The A524 features a new chassis and suspension layout aimed at providing a wider operating window for the car's aerodynamics. It represents a long-term development push to return to the front of the midfield.",
			maxSpeed: 338,
			overclockingTo100: 2.6,
			Weight: 798
		)
	]
}
