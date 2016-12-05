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
    
    

    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var retypeEmail: UITextField!
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

    @IBAction func btnRegistration(_ sender: AnyObject) {
        
        
        
        if passwordTextField.text == retypePasswordTextField.text && emailTextField.text == retypeEmail.text {
            password = passwordTextField.text!
            email = emailTextField.text!
            print("password & email matches")
            
            FIRAuth.auth()?.createUser(withEmail: email, password: password) { (user, error) in
                if error != nil {
                    print("error\(error)")
                } else {
                    
                    let user = FIRAuth.auth()?.currentUser
                    
                    if let user = user {
                        let changeRequest = user.profileChangeRequest()
                        changeRequest.displayName = self.userName.text!
                        
                        changeRequest.commitChanges { error in
                            if let error = error {
                                print(error)
                            } else {
                                let vc = self.storyboard?.instantiateViewController(withIdentifier: "storyboardLoggedIn") as! ViewControllerLoggedIn
                                self.show(vc, sender: vc)
                            }
                            
                        }
                    }
                    
                    
                    
                    
                    print("registration successful")
                }
            }

            
        } else {
            print("try again!")
        }
        
    }
    
    
    @IBAction func btnCancel(_ sender: AnyObject) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
