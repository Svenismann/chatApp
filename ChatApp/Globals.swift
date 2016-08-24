//
//  Globals.swift
//  ChatApp
//
//  Created by Sven Forstner on 24.08.16.
//  Copyright © 2016 Sven Forstner. All rights reserved.
//

import Foundation
import Firebase
import FirebaseDatabase

var BASE_URL = FIRDatabase.database().reference()

var userDefaults = NSUserDefaults.standardUserDefaults()

struct systemVars {
    
    static var userUid = userDefaults.objectForKey("userUid")
    
    static var loggedInStatus = Bool()
    
    
    
    
}



