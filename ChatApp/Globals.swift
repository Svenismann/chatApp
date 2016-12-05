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


var rootRef = FIRDatabase.database().reference()
var BASE_URL = String(describing: FIRDatabase.database().reference())

var userDefaults = UserDefaults.standard

struct systemVars {
    
    
    
    static var userUid = String(describing: userDefaults.object(forKey: "userUid"))
    
    static var loggedInStatus = Bool()
    
    
    
    
}



