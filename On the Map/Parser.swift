//
//  Parser.swift
//  On the Map
//
//  Created by Aayush Kapoor on 13/09/16.
//  Copyright © 2016 Aayush Kapoor. All rights reserved.
//

import Foundation

class Parser {
    static func parseMapPins(json: [String: AnyObject]) throws -> [MapPin]? {

        guard let pins = json["results"] as? [[String: AnyObject]] else {
            print("results")
            throw Error("Parse error: results", domain: "JSON")
        }

        var mapPins = [MapPin]()

        for pin in pins {

            let firstName: String
            let lastName: String

            let latitude: Float
            let longitude: Float

            let mapString: String
            let mediaUrl: String
            
            let objectId: String
            let uniqueKey: String


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

            if let _mediaUrl = pin["mediaUrl"] as? String {
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


            let mapPin = MapPin(firstName: firstName, lastName: lastName, latitude: latitude, longitude: longitude, mapString: mapString, mediaUrl: mediaUrl, objectId: objectId, uniqueKey: uniqueKey)
            mapPins.append(mapPin)
        }

        return mapPins
    }
}
