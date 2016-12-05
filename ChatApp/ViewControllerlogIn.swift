//
//  ViewController.swift
//  ChatApp
//
//  Created by Sven Forstner on 24.08.16.
//  Copyright © 2016 Sven Forstner. All rights reserved.
//

import UIKit
import Firebase




class ViewControllerLogIn: UIViewController {
    
    var userDefaults = UserDefaults.standard
    
    var ref = FIRDatabaseReference()
    
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    var username: String = ""
    var password: String = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(" reference : \(BASE_URL)")
        
        self.ref =  rootRef
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
        
        
    }
    
    @IBAction func btnRegistration(_ sender: AnyObject) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "storyboardRegistration") as! ViewControllerRegistration
        self.show(vc, sender: vc)
    
                    
    }
    
    @IBAction func btnForgetPassword(_ sender: AnyObject) {
    }
    
    @IBAction func btnLogInPressed(_ sender: AnyObject) {
        self.username = self.userNameTextField.text!
        self.password = self.passwordTextField.text!
        print(self.username, self.password)
        
        
        FIRAuth.auth()?.signIn(withEmail: username, password: password) { (user, error) in
            // ...
            if error != nil {
                print("there is an Error!\(error)")
            } else {
                print("logged in")
                
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "storyboardLoggedIn") as! ViewControllerLoggedIn
                self.show(vc, sender: vc)
                let currentUser = FIRAuth.auth()?.currentUser?.uid
                print(currentUser as Any)
                
                self.userDefaults.set(currentUser, forKey: "userUid")
                
                systemVars.loggedInStatus = true
                
                print("logged in : \(systemVars.loggedInStatus)")
                
                
                
            }
            
        }
        
    }
 
}

