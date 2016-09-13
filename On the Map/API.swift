//
//  API.swift
//  On the Map
//
//  Created by Aayush Kapoor on 12/09/16.
//  Copyright © 2016 Aayush Kapoor. All rights reserved.
//

import Foundation

enum Domain: String {
    case Parse = "https://parse.udacity.com/parse/"
    case Udacity = "https://www.udacity.com/api/"
}

func Error(error: String, domain: String) -> NSError {
    let userInfo = [NSLocalizedDescriptionKey: error]
    return NSError(domain: domain, code: 0, userInfo: userInfo)
}

class API {

    static func get(domain: Domain, handler: (result: AnyObject!, error: NSError?) -> Void) {

        let request = NSMutableURLRequest(URL: NSURL(string: domain.rawValue)!)

        request.HTTPMethod = "GET"

        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithRequest(request) { (data, response, error) in

            guard error == nil else {
                handler(result: nil, error: Error("Data task error", domain: "GET"))
                return
            }

            guard let statusCode = (response as? NSHTTPURLResponse)?.statusCode where statusCode >= 200 && statusCode <= 299 else {
                handler(result: nil, error: Error("Response status code not 2xx", domain: "GET"))
                return
            }

            guard data != nil else {
                handler(result: nil, error: Error("No data recieved from the server", domain: "GET"))
                return
            }

            do {
                let parsedData = try NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments) as! [String: AnyObject]
                handler(result: parsedData, error: nil)
            } catch {
                handler(result: nil, error: Error("Cannot parse JSON data", domain: "GET"))
                return
            }

        }

        task.resume()
    }

    static func post(domain: Domain, body: String, handler: (result: AnyObject!, error: NSError?) -> Void) {

        let request = NSMutableURLRequest(URL: NSURL(string: domain.rawValue)!)

        request.HTTPMethod = "POST"

        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.HTTPBody = body.dataUsingEncoding(NSUTF8StringEncoding)

        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithRequest(request) { (data, response, error) in

            guard error == nil else {
                handler(result: nil, error: Error("Data task error", domain: "POST"))
                return
            }

            guard let statusCode = (response as? NSHTTPURLResponse)?.statusCode where statusCode >= 200 && statusCode <= 299 else {
                handler(result: nil, error: Error("Response status code not 2xx", domain: "POST"))
                return
            }

            guard data != nil else {
                handler(result: nil, error: Error("No data recieved from the server", domain: "POST"))
                return
            }

            do {
                let parsedData = try NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments) as! [String: AnyObject]
                handler(result: parsedData, error: nil)
            } catch {
                handler(result: nil, error: Error("Cannot parse JSON data", domain: "POST"))
                return
            }

        }

        task.resume()
    }
}
