//
//  Helpers.swift
//  greet
//
//  Created by Tyler Geery on 2/5/15.
//  Copyright (c) 2015 Geerydev. All rights reserved.
//

import Foundation

class Helpers {
    func JSONStringify(value: AnyObject) -> String {
        if NSJSONSerialization.isValidJSONObject(value) {
            if let data = NSJSONSerialization.dataWithJSONObject(value, options: nil, error: nil) {
                if let string = NSString(data: data, encoding: NSUTF8StringEncoding) {
                    return string
                }
            }
        }
        return ""
    }
    
    func prepForPost(value: AnyObject) -> NSData {
        let string = self.JSONStringify(value)
        return string.dataUsingEncoding(NSUTF8StringEncoding)!
    }

}