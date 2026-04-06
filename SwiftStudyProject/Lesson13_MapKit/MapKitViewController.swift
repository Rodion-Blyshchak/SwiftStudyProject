//
//  MapKitViewController.swift
//  SwiftStudyProject
//
//  Created by Rodion Blyshchak on 29.03.2026.
//

import UIKit
import MapKit

class MapKitViewController: UIViewController {
	private var mockDataCars = CoreDataManager.shared.fetchAllCars()
	
	private let mapView: MKMapView = {
		let map = MKMapView()
		map.translatesAutoresizingMaskIntoConstraints = false
		return map
	}()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		mapView.delegate = self
		
		setupMapView()
		displayCarsOnMap()
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		
		self.mockDataCars = CoreDataManager.shared.fetchAllCars()
		displayCarsOnMap()
	}
	
	private func setupMapView() {
		view.addSubview(mapView)
		
		NSLayoutConstraint.activate([
			mapView.topAnchor.constraint(equalTo: view.topAnchor),
			mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
			mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
		])
	}
	
	private func displayCarsOnMap() {
		mapView.removeAnnotations(mapView.annotations)
		
		var annotations: [MKPointAnnotation] = []
		
		mockDataCars.forEach{ location in
			let annotation = MKPointAnnotation()
			annotation.title = location.name
			annotation.subtitle  = location.team
			annotation.coordinate = CLLocationCoordinate2D(
				latitude: location.location?.latitude ?? 0,
				longitude: location.location?.longitude ?? 0
			)
			
			annotations.append(annotation)
		}
		
		mapView.addAnnotations(annotations)
		mapView.showAnnotations(annotations, animated: true)
	}
}

extension MapKitViewController: MKMapViewDelegate {
	func mapView(_ mapView: MKMapView, viewFor annotation: any MKAnnotation) -> MKAnnotationView? {
		if annotation is MKClusterAnnotation {
			return nil
		}
		
		let identifier = "CarAnnotation"
		var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
		
		if annotationView == nil {
			annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: identifier)
			annotationView?.canShowCallout = true
		} else {
			annotationView?.annotation = annotation
		}
		
		if let image = UIImage(named: "Car F1") {
			annotationView?.image = image.resized(to: CGSize(width: 50, height: 50))
		}
		
		annotationView?.clusteringIdentifier = "trackCluster"
		
		return annotationView
	}
}

extension UIImage {
	func resized(to size: CGSize) -> UIImage {
		let renderer = UIGraphicsImageRenderer(size: size)
		return renderer.image { _ in
			draw(in: CGRect(origin: .zero, size: size))
		}
	}
}

