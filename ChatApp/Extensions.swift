//
//  Extensions.swift
//  ChatApp
//
//  Created by Sven Forstner on 27.08.16.
//  Copyright © 2016 Sven Forstner. All rights reserved.
//

import Foundation
import Firebase

extension FIRDataSnapshot {
    var json : JSON {
        return JSON(self.value! as AnyObject)
    }
}

extension String {
    func URLEncodedString() -> String? {
        //let customAllowedSet =  NSCharacterSet.URLQueryAllowedCharacterSet()
        let customAllowedSet = CharacterSet.alphanumerics
        //let escapedString = self.stringByAddingPercentEncodingWithAllowedCharacters(customAllowedSet)
        let escapedString = self.addingPercentEncoding(withAllowedCharacters: customAllowedSet)
        return escapedString
    }
    
    func URLDecodedString() -> String? {
        let unescapedString = self.removingPercentEncoding
        return unescapedString
    }
    
    static func queryStringFromParameters(_ parameters: Dictionary<String,String>, inclQuestionMark: Bool = true) -> String? {
        if (parameters.count == 0)
        {
            return nil
        }
        var queryString : String? = nil
        for (key, value) in parameters {
            if let encodedKey = key.URLEncodedString() {
                if let encodedValue = value.URLEncodedString() {
                    if queryString == nil
                    {
                        queryString = inclQuestionMark ? "?" : ""
                    }
                    else
                    {
                        queryString! += "&"
                    }
                    queryString! += encodedKey + "=" + encodedValue
                }
            }
        }
        return queryString
    }
    
    func trim() -> String {
        return self.trimmingCharacters(in: CharacterSet.whitespaces)
    }
}
