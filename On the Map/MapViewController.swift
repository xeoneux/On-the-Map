//
//  MapViewController.swift
//  On the Map
//
//  Created by Aayush Kapoor on 13/09/16.
//  Copyright © 2016 Aayush Kapoor. All rights reserved.
//

import MapKit
import UIKit

class MapViewController: UIViewController, MKMapViewDelegate {

    @IBOutlet weak var mapView: MKMapView!

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(self.viewDidLoad), name:"ReloadData", object: nil)
    }

    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: "ReloadData", object: nil)
    }

    override func viewDidLoad() {

        mapView.delegate = self

        mapView.removeAnnotations(mapView.annotations)

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

    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {

        let pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "Pin")

        pinView.canShowCallout = true
        pinView.pinTintColor = UIColor.redColor()
        pinView.rightCalloutAccessoryView = UIButton(type: .DetailDisclosure)

        return pinView
    }

    func mapView(mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {

        if control == view.rightCalloutAccessoryView {
            let app = UIApplication.sharedApplication()
            if let string = view.annotation?.subtitle! {
                app.openURL(NSURL(string: string)!)
            }
        }
    }
}
