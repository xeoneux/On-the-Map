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

        getNames()
    }

    func getNames() {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let uniqueKey = appDelegate.uniqueKey

        let api = API(domain: .Udacity)
        api.get(uniqueKey, handler: {
            if let result = $0.result {
                let names = try! Parser.parseUserInfo(result)
                appDelegate.firstName = names.0
                appDelegate.lastName = names.1
            }
        })
    }

    @IBAction func logout(sender: AnyObject) {
        let api = API(domain: .Udacity)
        api.delete({
            if $0.error == nil {
                dispatch_async(dispatch_get_main_queue(), {
                    self.dismissViewControllerAnimated(true, completion: nil)
                })
            } else {
                print($0.error!)
            }
        })
    }

    @IBAction func refresh(sender: AnyObject) {
        MapPin.downloadPins()
    }

    @IBAction func pinOnTheMap(sender: AnyObject) {
        let locationViewController = storyboard?.instantiateViewControllerWithIdentifier("Location Controller") as! LocationViewController
        navigationController?.pushViewController(locationViewController, animated: true)
    }
}
