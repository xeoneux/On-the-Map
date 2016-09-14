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

            guard let firstName = pin["firstName"] as? String else {
                throw Error("Parse error: firstName", domain: "JSON")
            }
            guard let lastName = pin["lastName"] as? String else {
                throw Error("Parse error: lastName", domain: "JSON")
            }


            guard let latitude = pin["latitude"] as? Float else {
                throw Error("Parse error: latitude", domain: "JSON")
            }
            guard let longitude = pin["longitude"] as? Float else {
                throw Error("Parse error: longitude", domain: "JSON")
            }


            guard let mapString = pin["mapString"] as? String else {
                throw Error("Parse error: mapString", domain: "JSON")
            }
            guard let mediaURL = pin["mediaURL"] as? String else {
                throw Error("Parse error: mediaURL", domain: "JSON")
            }


            guard let objectId = pin["objectId"] as? String else {
                throw Error("Parse error: objectId", domain: "JSON")
            }
            guard let uniqueKey = pin["uniqueKey"] as? String else {
                throw Error("Parse error: uniqueKey", domain: "JSON")
            }

            let mapPin = MapPin(firstName: firstName, lastName: lastName, latitude: latitude, longitude: longitude, mapString: mapString, mediaUrl: mediaURL, objectId: objectId, uniqueKey: uniqueKey)
            mapPins.append(mapPin)
        }

        return mapPins
    }
}
