//
//  MapViewController.swift
//  On the Map
//
//  Created by Aayush Kapoor on 13/09/16.
//  Copyright © 2016 Aayush Kapoor. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate {

    @IBOutlet weak var mapView: MKMapView!

    override func viewDidLoad() {
        let annotations: [MKPointAnnotation] = MapPin.getPins().map {
            let latitude = CLLocationDegrees($0.latitude)
            let longitude = CLLocationDegrees($0.longitude)
            let coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)

            let firstName = $0.firstName
            let lastName = $0.lastName
            let title = "\(firstName) \(lastName)"

            let annotation = MKPointAnnotation()
            annotation.title = title
            annotation.subtitle = $0.mediaUrl
            annotation.coordinate = coordinate

            return annotation
        }

        mapView.addAnnotations(annotations)
    }
}
