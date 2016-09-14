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
        NSNotificationCenter.defaultCenter().postNotificationName("ReloadData", object: nil)
    }

    @IBAction func logout(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
}
