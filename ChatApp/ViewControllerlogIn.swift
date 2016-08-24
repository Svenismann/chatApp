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
    
    var userDefaults = NSUserDefaults.standardUserDefaults()
    
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    var username: String = ""
    var password: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
        
        
    }
    
    @IBAction func btnRegistration(sender: AnyObject) {
        let vc = self.storyboard?.instantiateViewControllerWithIdentifier("storyboardRegistration") as! ViewControllerRegistration
        self.showViewController(vc, sender: vc)
    
                    
    }
    
    @IBAction func btnForgetPassword(sender: AnyObject) {
    }
    
    @IBAction func btnLogInPressed(sender: AnyObject) {
        self.username = self.userNameTextField.text!
        self.password = self.passwordTextField.text!
        print(self.username, self.password)
        
        
        FIRAuth.auth()?.signInWithEmail(username, password: password) { (user, error) in
            // ...
            if error != nil {
                print("there is an Error!\(error)")
            } else {
                print("logged in")
                
                let vc = self.storyboard?.instantiateViewControllerWithIdentifier("storyboardLoggedIn") as! ViewControllerLoggedIn
                self.showViewController(vc, sender: vc)
                let currentUser = FIRAuth.auth()?.currentUser?.uid
                print(currentUser)
                
                self.userDefaults.setObject(currentUser, forKey: "userUid")
                
                systemVars.loggedInStatus = true
                
                print("logged in : \(systemVars.loggedInStatus)")
                
                
                
            }
            
        }
        
    }
 
}

