//
//  LocationViewController.swift
//  On the Map
//
//  Created by Aayush Kapoor on 16/09/16.
//  Copyright © 2016 Aayush Kapoor. All rights reserved.
//

import MapKit
import UIKit

class LocationViewController: UIViewController {

    let submitButton = UIButton(type: .System)
    @IBOutlet weak var searchButton: UIButton!

    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var textField: UITextField!

    @IBOutlet weak var stackView: UIStackView!

    override func viewDidLoad() {
        textView.text = "Where are you\nStudying\nToday?"
        textView.textAlignment = .Center

        textField.textColor = UIColor.whiteColor()
        textField.backgroundColor = UIColor(red: 2/255, green: 179/255, blue: 228/255, alpha: 1)
    }

    @IBAction func findOnTheMap(sender: AnyObject) {
        if textField.text?.characters.count != 0 {

            let searchText = textField.text

            // Remove all views
            stackView.arrangedSubviews.forEach {
                stackView.removeArrangedSubview($0)
            }

            // Add text field view
            textField.text = ""
            textField.placeholder = "Enter a Link to Share Here"
            stackView.addArrangedSubview(textField)

            // Add map view
            let mapView = MKMapView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
            stackView.addArrangedSubview(mapView)

            // Add button view
            submitButton.setTitle("Submit", forState: .Normal)
            stackView.addArrangedSubview(submitButton)

            // Search for location
            let request = MKLocalSearchRequest()
            request.naturalLanguageQuery = searchText
            let search = MKLocalSearch(request: request)
            search.startWithCompletionHandler {
                guard let response = $0.0 else {
                    return
                }

                mapView.centerCoordinate = (response.mapItems.first?.placemark.coordinate)!
            }
        }
    }
}
