//
//  LocationViewController.swift
//  On the Map
//
//  Created by Aayush Kapoor on 16/09/16.
//  Copyright © 2016 Aayush Kapoor. All rights reserved.
//

import UIKit

class LocationViewController: UIViewController {

    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var textField: UITextField!

    override func viewDidLoad() {
        textView.text = "Where are you\nStudying\nToday?"

        textField.backgroundColor = UIColor(red: 2/255, green: 179/255, blue: 228/255, alpha: 1)
    }

    @IBAction func findOnTheMap(sender: AnyObject) {
    }
}
