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
    case Udacity = "https://www.udacity.com/api/session"
}

func Error(code: Int, error: String, domain: String) -> NSError {
    let userInfo = [NSLocalizedDescriptionKey: error]
    return NSError(domain: domain, code: code, userInfo: userInfo)
}

struct API {

    let domain: Domain

    init(domain: Domain) {
        self.domain = domain
    }

    func get(data: String?, handler: (result: AnyObject?, error: NSError?) -> Void) {

        let url: String

        if domain == .Udacity {
            url = "https://www.udacity.com/api/users/\(data!)"
        } else {
            url = domain.rawValue + "?limit=100&order=-updatedAt".stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!
        }

        let request = NSMutableURLRequest(URL: NSURL(string: url)!)

        request.HTTPMethod = "GET"
        Header(request)

        Task(request, handler: handler)
    }

    func post(body: String, handler: (result: AnyObject?, error: NSError?) -> Void) {

        let request = NSMutableURLRequest(URL: NSURL(string: domain.rawValue)!)

        request.HTTPMethod = "POST"
        Header(request)

        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.HTTPBody = body.dataUsingEncoding(NSUTF8StringEncoding)

        Task(request, handler: handler)
    }

    func put(objectId: String, body: String, handler: (result: AnyObject?, error: NSError?) -> Void) {

        let request = NSMutableURLRequest(URL: NSURL(string: domain.rawValue + objectId)!)

        request.HTTPMethod = "PUT"
        Header(request)

        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.HTTPBody = body.dataUsingEncoding(NSUTF8StringEncoding)

        Task(request, handler: handler)
    }

    func delete(handler: (result: AnyObject?, error: NSError?) -> Void) {

        let request = NSMutableURLRequest(URL: NSURL(string: domain.rawValue)!)

        let cookieStorage = NSHTTPCookieStorage.sharedHTTPCookieStorage()

        let xsrfCookie = cookieStorage.cookies?.filter {
            $0.name == "XSRF-TOKEN"
        }.first

        guard xsrfCookie != nil else {
            handler(result: nil, error: Error(0, error: "No cookie found", domain: "API"))
            return
        }

        request.setValue(xsrfCookie?.value, forHTTPHeaderField: "X-XSRF-TOKEN")

        request.HTTPMethod = "DELETE"
        Header(request)

        Task(request, handler: handler)
    }

    private func Header(request: NSMutableURLRequest) {
        switch domain {
        case .Parse:
            request.addValue(Constants.Parse.ApplicationId, forHTTPHeaderField: "X-Parse-Application-Id")
            request.addValue(Constants.Parse.restApiKey, forHTTPHeaderField: "X-Parse-REST-API-Key")
        case .Udacity:
            break
        }
    }

    private func Task(request: NSMutableURLRequest, handler: (result: AnyObject?, error: NSError?) -> Void) {
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithRequest(request) { (data, response, error) in

            guard error == nil else {
                handler(result: nil, error: Error(0, error: "Data task error", domain: "API"))
                return
            }

            guard let invalidCredentials = (response as? NSHTTPURLResponse)?.statusCode where invalidCredentials != 403 else {
                handler(result: nil, error: Error(403, error: "Response status code 403", domain: "API"))
                return
            }

            guard let statusCode = (response as? NSHTTPURLResponse)?.statusCode where statusCode >= 200 && statusCode <= 299 else {
                handler(result: nil, error: Error(200, error: "Response status code not 2xx", domain: "API"))
                return
            }

            guard data != nil else {
                handler(result: nil, error: Error(204, error: "No data recieved from the server", domain: "API"))
                return
            }

            let subdata: NSData?

            if self.domain == .Udacity {
                subdata = data?.subdataWithRange(NSMakeRange(5, data!.length - 5))
            } else {
                subdata = data
            }

            do {
                let parsedData = try NSJSONSerialization.JSONObjectWithData(subdata!, options: .AllowFragments)
                handler(result: parsedData, error: nil)
            } catch {
                handler(result: nil, error: Error(1, error: "Cannot parse JSON data", domain: "API"))
                return
            }
            
        }
        
        task.resume()
    }
}
