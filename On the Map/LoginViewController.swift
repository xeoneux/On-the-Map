//
//  LoginViewController.swift
//  On the Map
//
//  Created by Aayush Kapoor on 12/09/16.
//  Copyright © 2016 Aayush Kapoor. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var loginButton: UIButton!

    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)

        loginButton.layer.cornerRadius = 5.0
        loginButton.backgroundColor = UIColor(red: 2/255, green: 179/255, blue: 228/255, alpha: 1)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func login(sender: AnyObject) {
        if emailField.text?.characters.count != 0 && passwordField.text?.characters.count != 0 {
            let email = emailField.text
            let password = passwordField.text
            let credentials = "{\"udacity\": {\"username\": \"\(email!)\", \"password\": \"\(password!)\"}}"

            let api = API(domain: .Udacity)
            api.post(credentials, handler: {
                if let result = $0.result {
                    let info = try! Parser.parseSession(result)

                    if info.0 {
                        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
                        appDelegate.uniqueKey = info.1

                        dispatch_async(dispatch_get_main_queue(), {
                            let navigationController = self.storyboard?.instantiateViewControllerWithIdentifier("Navigation Controller")
                            self.presentViewController(navigationController!, animated: true, completion: nil)
                        })
                    } else {
                        print(info.1)
                    }

                } else {
                    if $0.error!.code == 403 {
                        dispatch_async(dispatch_get_main_queue(), {
                            let alertController = UIAlertController(title: "Invalid Credentials", message: "The entered email or password is incorrect", preferredStyle: .Alert)
                            alertController.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
                            self.presentViewController(alertController, animated: true, completion: nil)
                        })
                    } else {
                        dispatch_async(dispatch_get_main_queue(), {
                            let alertController = UIAlertController(title: "Failure to Connect", message: "Could not connect to the server", preferredStyle: .Alert)
                            alertController.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
                            self.presentViewController(alertController, animated: true, completion: nil)
                        })
                    }
                }
            })
        } else {
            let alertController = UIAlertController(title: "Blank Fields", message: "Please enter email address and password", preferredStyle: .Alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
            self.presentViewController(alertController, animated: true, completion: nil)
        }
    }

}

