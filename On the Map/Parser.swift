//
//  Parser.swift
//  On the Map
//
//  Created by Aayush Kapoor on 13/09/16.
//  Copyright © 2016 Aayush Kapoor. All rights reserved.
//

import Foundation

class Parser {
    static func parseMapPins(json: [String: AnyObject]) -> [MapPin]? {

        guard let pins = json["results"] as? [[String: AnyObject]] else {
            Error("Parse error: results", domain: "JSON")
            return nil
        }

        var mapPins = [MapPin]()

        for pin in pins {

            guard let firstName = pin["firstName"] as? String else {
                Error("Parse error: firstName", domain: "JSON")
                break
            }
            guard let lastName = pin["lastName"] as? String else {
                Error("Parse error: lastName", domain: "JSON")
                break
            }


            guard let latitude = pin["latitude"] as? Float else {
                Error("Parse error: latitude", domain: "JSON")
                break
            }
            guard let longitude = pin["longitude"] as? Float else {
                Error("Parse error: longitude", domain: "JSON")
                break
            }


            guard let mapString = pin["mapString"] as? String else {
                Error("Parse error: mapString", domain: "JSON")
                break
            }
            guard let mediaURL = pin["mediaURL"] as? String else {
                Error("Parse error: mediaURL", domain: "JSON")
                break
            }


            guard let objectId = pin["objectId"] as? String else {
                Error("Parse error: objectId", domain: "JSON")
                break
            }
            guard let uniqueKey = pin["uniqueKey"] as? Int else {
                Error("Parse error: uniqueKey", domain: "JSON")
                break
            }

            let mapPin = MapPin(firstName: firstName, lastName: lastName, latitude: latitude, longitude: longitude, mapString: mapString, mediaUrl: mediaURL, objectId: objectId, uniqueKey: uniqueKey)
            mapPins.append(mapPin)
        }

        return mapPins
    }
}
