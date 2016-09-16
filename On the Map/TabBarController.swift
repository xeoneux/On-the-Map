//
//  TabBarController.swift
//  On the Map
//
//  Created by Aayush Kapoor on 13/09/16.
//  Copyright © 2016 Aayush Kapoor. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {

    @IBOutlet weak var logoutButton: UIBarButtonItem!

    @IBOutlet weak var pinButton: UIBarButtonItem!
    @IBOutlet weak var refreshButton: UIBarButtonItem!

    override func viewDidLoad() {
        MapPin.downloadPins()
    }

    @IBAction func logout(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }

    @IBAction func refresh(sender: AnyObject) {
        MapPin.downloadPins()
    }

    @IBAction func pinOnTheMap(sender: AnyObject) {
        let locationViewController = storyboard?.instantiateViewControllerWithIdentifier("Location Controller") as! LocationViewController
        presentViewController(locationViewController, animated: true, completion: nil)
    }
}
