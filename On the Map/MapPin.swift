//
//  MapPin.swift
//  On the Map
//
//  Created by Aayush Kapoor on 13/09/16.
//  Copyright © 2016 Aayush Kapoor. All rights reserved.
//

import UIKit

var MapPins = [MapPin]()

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
        return MapPins
    }

    static func setPins(mapPins: [MapPin]) {
        MapPins = mapPins
    }

    static func downloadPins() {
        let api = API(domain: .Parse)
        api.get(nil, handler: {
            if $0.result != nil {
                let result = $0.result as! [String: AnyObject]
                setPins(try! Parser.parseMapPins(result)!)
                NSNotificationCenter.defaultCenter().postNotificationName("ReloadData", object: nil)
            }
        })
    }
}
