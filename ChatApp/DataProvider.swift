//
//  DataProvider.swift
//  ChatApp
//
//  Created by Sven Forstner on 27.08.16.
//  Copyright © 2016 Sven Forstner. All rights reserved.
//

import Foundation
import Firebase

class DataProvider {
    static let dataProvider = DataProvider()
    
    fileprivate let _BASE_REF = FIRDatabaseReference().child(BASE_URL)
    fileprivate let _USER_REF = FIRDatabaseReference().child("\(BASE_URL)/users")
    fileprivate let _MESSAGE_REF = FIRDatabaseReference().child("\(BASE_URL)/\(systemVars.userUid)/message")
    
}
