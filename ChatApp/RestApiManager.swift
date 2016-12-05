//
//  RestApiManager.swift
//  ChatApp
//
//  Created by Sven Forstner on 28.08.16.
//  Copyright © 2016 Sven Forstner. All rights reserved.
//

import Foundation

typealias ServiceResponse = (JSON, NSError?) -> Void
var RestApiManagerDebug:Bool = false


class RestApiManager: NSObject {
    static let sharedInstance = RestApiManager()
    internal var debugRequest:Bool = false
    
    func getData(_ requestUri: String, onCompletion: @escaping (JSON) -> Void) {
        makeHTTPGetRequest(Constants.domain + requestUri, onCompletion: { json, err -> Void in
            guard err == nil else {
                print("*** getData Error: \(err)")
                onCompletion(["status": "Error", "errorCode": String(err!.code), "errorString": err.debugDescription as Any])
                
                return
            }
            
            onCompletion(json)
        })
    }
    
    func postData(_ requestUri: String, requestBody: AnyObject, onCompletion: @escaping (JSON, Error?) -> Void) {
        makeHTTPPostRequest(Constants.domain + requestUri, requestBody: requestBody, onCompletion: { json, err -> Void in
            
            guard err == nil else {
                print("*** postData Error: \(err)")
                onCompletion(nil, err!)
                
                return
            }
            
            onCompletion(json, nil)
        })
    }
    
    /*
     func addDummyData() {
     RestApiManager.sharedInstance.getRandomUser { (json: JSON) in
     let results: JSON = json["results"]
     for (key, subJson) in results {
     if let user: AnyObject = subJson["user"].object {
     self.items.addObject(user)
     dispatch_async(dispatch_get_main_queue(),{
     tableView?.reloadData()
     })
     }
     }
     }
     }
     */
    
    func makeHTTPGetRequest(_ path: String, onCompletion: @escaping ServiceResponse) {
        var request = URLRequest(url: URL(string: path)!)
        request.cachePolicy = NSURLRequest.CachePolicy.reloadIgnoringCacheData
        
        let session = URLSession.shared
        
        let task = session.dataTask(with: request, completionHandler: { data, response, error -> Void in
            if (data != nil) {
                let json:JSON = JSON(data: data!)
                onCompletion(json, error as NSError?)
                return
            } else {
                onCompletion(nil, error as NSError?)
                return
            }
        })
        task.resume()
    }
    
    func makeHTTPPostRequest(_ path: String, requestBody: AnyObject, onCompletion: @escaping ServiceResponse) {
        var postData: String
        
        if requestBody.isKind(of: NSDictionary.self) {
            postData = String.queryStringFromParameters(requestBody as! Dictionary<String, String>, inclQuestionMark: false)!
        } else {
            postData = requestBody as! String
        }
        
        if RestApiManagerDebug {
            print("Request data: \(postData)");
            RestApiManagerDebug = false
        }
        
        //let cachePolicy = NSURLRequestCachePolicy.ReloadIgnoringLocalCacheData
        var request = URLRequest(url: URL(string: path)!)
        
        // Set the method to POST
        request.httpMethod = "POST"
        request.httpBody = postData.data(using: String.Encoding.utf8)!
        request.cachePolicy = NSURLRequest.CachePolicy.reloadIgnoringCacheData
        //request.timeoutInterval = 120
        
        
        request.setValue(String(postData.characters.count), forHTTPHeaderField: "Content-Length")
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        
        let session = URLSession.shared
        
        let task = session.dataTask(with: request, completionHandler: {data, response, error -> Void in
            guard error == nil else {
                print("Error makeHTTPPostRequest: \(error)")
                onCompletion(nil, error as NSError?)
                return
            }
            
            let res = response as! HTTPURLResponse
            
            if res.statusCode == 200 {
                let json:JSON = JSON(data: data!)
                onCompletion(json, error as NSError?)
            }
        })
        task.resume()
    }
}
