//
//  ViewControllerRegistration.swift
//  ChatApp
//
//  Created by Sven Forstner on 24.08.16.
//  Copyright © 2016 Sven Forstner. All rights reserved.
//

import UIKit
import Firebase

class ViewControllerRegistration: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var retypePasswordTextField: UITextField!
    
    var email: String = ""
    var password: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func btnRegistration(sender: AnyObject) {
        
        email = emailTextField.text!
        
        if passwordTextField.text == retypePasswordTextField.text {
            password = passwordTextField.text!
            print("password matches")
            
            FIRAuth.auth()?.createUserWithEmail(email, password: password) { (user, error) in
                if error != nil {
                    print("error\(error)")
                } else {
                    print("registration successful")
                }
            }

            
        } else {
            print("try again!")
        }
        
    }
    
    
    @IBAction func btnCancel(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
}
