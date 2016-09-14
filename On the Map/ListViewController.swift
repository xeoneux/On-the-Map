//
//  ListViewController.swift
//  On the Map
//
//  Created by Aayush Kapoor on 13/09/16.
//  Copyright © 2016 Aayush Kapoor. All rights reserved.
//

import UIKit

class ListViewController: UITableViewController {
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MapPin.getPins().count
    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        return
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let pin = MapPin.getPins()[indexPath.row]
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell")!

        cell.textLabel?.text = pin.firstName + " " + pin.lastName

        return cell
    }
}
