//
//  TabBarController.swift
//  On the Map
//
//  Created by Aayush Kapoor on 13/09/16.
//  Copyright © 2016 Aayush Kapoor. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        navigationController?.navigationBar.items = [UINavigationItem(title: "On the Map")]
    }

}
