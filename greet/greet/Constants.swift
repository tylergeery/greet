//
//  Constants.swift
//  greet
//
//  Created by Tyler Geery on 2/2/15.
//  Copyright (c) 2015 Geerydev. All rights reserved.
//

import Foundation

struct Constants {
    struct API {
        static let BASE = "http://localhost:3000/"

        struct USER {
            static let ALL = Constants.API.BASE + "user/all"
            static let POSTLOGIN = Constants.API.BASE + "user/postlogin"
            static let POSTPHOTOS = Constants.API.BASE + "user/postphotos"
            static let ME = Constants.API.BASE + "user/me"
        }

        struct GROUPS {
            
        }
    }
}