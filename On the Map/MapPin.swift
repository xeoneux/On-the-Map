//
//  MapPin.swift
//  On the Map
//
//  Created by Aayush Kapoor on 13/09/16.
//  Copyright © 2016 Aayush Kapoor. All rights reserved.
//

import UIKit

struct MapPin {

    let firstName: String
    let lastName: String

    let latitude: Float
    let longitude: Float

    let mapString: String
    let mediaUrl: String

    let objectId: String
    let uniqueKey: String

    static func getPins() -> [MapPin] {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        return appDelegate.mapPins
    }

    static func setPins(mapPins: [MapPin]) {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        appDelegate.mapPins = mapPins
    }

    static func downloadPins() {
        API.get(.Parse, handler: {
            if $0.result != nil {
                setPins(try! Parser.parseMapPins($0.result!)!)
            }
        })
    }
}
