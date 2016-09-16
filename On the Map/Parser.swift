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
            throw Error("Parse error: results", domain: "MapPins")
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

    static func parseSession(json: AnyObject) throws -> (Bool, String) {
        let data = json as! [String: AnyObject]

        guard let account = data["account"] as? [String: AnyObject] else {
            throw Error("Parse error: account", domain: "Session")
        }

        guard let registered = account["registered"] else {
            throw Error("Parse error: registered", domain: "Session")
        }

        guard let key = account["key"] else {
            throw Error("Parse error: key", domain: "Session")
        }

        return (registered as! Bool, key as! String)
    }

    static func parseUserInfo(json: AnyObject) throws -> (String, String) {
        let data = json as! [String: AnyObject]

        guard let user = data["user"] as? [String: AnyObject] else {
            throw Error("Parse error: user", domain: "UserInfo")
        }

        guard let firstName = user["first_name"] else {
            throw Error("Parse error: first_name", domain: "UserInfo")
        }

        guard let lastName = user["last_name"] else {
            throw Error("Parse error: last_name", domain: "UserInfo")
        }

        return (firstName as! String, lastName as! String)
    }
}
