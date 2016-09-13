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
        let navigationController = storyboard?.instantiateViewControllerWithIdentifier("Navigation Controller")
        presentViewController(navigationController!, animated: true, completion: nil)
    }

}

