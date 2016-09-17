//
//  MapPin.swift
//  On the Map
//
//  Created by Aayush Kapoor on 13/09/16.
//  Copyright © 2016 Aayush Kapoor. All rights reserved.
//

import UIKit

struct MapPin {

    static var MapPins = [MapPin]()

    let firstName: String
    let lastName: String

    let latitude: Float
    let longitude: Float

    let mapString: String
    let mediaUrl: String

    let objectId: String
    let uniqueKey: String

    init(firstName: String, lastName: String, latitude: Float, longitude: Float, mapString: String, mediaUrl: String, objectId: String, uniqueKey: String) {
        self.firstName = firstName
        self.lastName = lastName

        self.latitude = latitude
        self.longitude = longitude

        self.mapString = mapString
        self.mediaUrl = mediaUrl

        self.objectId = objectId
        self.uniqueKey = uniqueKey
    }

    init(pin: [String: AnyObject]) {

        if let _firstName = pin["firstName"] as? String {
            firstName = _firstName
        } else {
            firstName = ""
        }

        if let _lastName = pin["lastName"] as? String {
            lastName = _lastName
        } else {
            lastName = ""
        }


        if let _latitude = pin["latitude"] as? Float {
            latitude = _latitude
        } else {
            latitude = 0
        }

        if let _longitude = pin["longitude"] as? Float {
            longitude = _longitude
        } else {
            longitude = 0
        }


        if let _mapString = pin["mapString"] as? String {
            mapString = _mapString
        } else {
            mapString = ""
        }

        if let _mediaUrl = pin["mediaURL"] as? String {
            mediaUrl = _mediaUrl
        } else {
            mediaUrl = ""
        }


        if let _objectId = pin["objectId"] as? String {
            objectId = _objectId
        } else {
            objectId = ""
        }

        if let _uniqueKey = pin["uniqueKey"] as? String {
            uniqueKey = _uniqueKey
        } else {
            uniqueKey = ""
        }

    }

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
            } else {
                NSNotificationCenter.defaultCenter().postNotificationName("ReloadDataError", object: nil)
            }
        })
    }
}
