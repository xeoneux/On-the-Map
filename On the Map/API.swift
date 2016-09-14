//
//  API.swift
//  On the Map
//
//  Created by Aayush Kapoor on 12/09/16.
//  Copyright © 2016 Aayush Kapoor. All rights reserved.
//

import Foundation

enum Domain: String {
    case Parse = "https://parse.udacity.com/parse/classes/StudentLocation"
    case Udacity = "https://www.udacity.com/api/"
}

func Error(error: String, domain: String) -> NSError {
    let userInfo = [NSLocalizedDescriptionKey: error]
    return NSError(domain: domain, code: 0, userInfo: userInfo)
}

func Header(request: NSMutableURLRequest, domain: Domain) {
    switch domain {
    case .Parse:
        request.addValue(Constants.Parse.ApplicationId, forHTTPHeaderField: "X-Parse-Application-Id")
        request.addValue(Constants.Parse.restApiKey, forHTTPHeaderField: "X-Parse-REST-API-Key")
    case .Udacity:
        break
    }
}

func Task(request: NSMutableURLRequest, handler: (result: [String: AnyObject]?, error: NSError?) -> Void) {
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

class API {

    static func get(domain: Domain, handler: (result: [String: AnyObject]?, error: NSError?) -> Void) {

        let request = NSMutableURLRequest(URL: NSURL(string: domain.rawValue)!)

        request.HTTPMethod = "GET"
        Header(request, domain: domain)

        Task(request, handler: handler)
    }

    static func post(domain: Domain, body: String, handler: (result: [String: AnyObject]?, error: NSError?) -> Void) {

        let request = NSMutableURLRequest(URL: NSURL(string: domain.rawValue)!)

        request.HTTPMethod = "POST"
        Header(request, domain: domain)

        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.HTTPBody = body.dataUsingEncoding(NSUTF8StringEncoding)

        Task(request, handler: handler)
    }

    static func put(domain: Domain, objectId: String, body: String, handler: (result: [String: AnyObject]?, error: NSError?) -> Void) {

        let request = NSMutableURLRequest(URL: NSURL(string: domain.rawValue + objectId)!)

        request.HTTPMethod = "PUT"
        Header(request, domain: domain)

        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.HTTPBody = body.dataUsingEncoding(NSUTF8StringEncoding)

        Task(request, handler: handler)
    }

    static func delete(domain: Domain, body: String, handler: (result: [String: AnyObject]?, error: NSError?) -> Void) {

        let request = NSMutableURLRequest(URL: NSURL(string: domain.rawValue)!)

        let cookieStorage = NSHTTPCookieStorage.sharedHTTPCookieStorage()

        let xsrfCookie = cookieStorage.cookies?.filter {
            $0.name == "XSRF-TOKEN"
        }.first

        guard xsrfCookie != nil else {
            handler(result: nil, error: Error("No cookie found", domain: "API"))
            return
        }

        request.setValue(xsrfCookie?.value, forHTTPHeaderField: "X-XSRF-TOKEN")

        request.HTTPMethod = "DELETE"
        Header(request, domain: domain)

        Task(request, handler: handler)
    }
}
