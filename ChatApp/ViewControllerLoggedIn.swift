//
//  ViewControllerLoggedIn.swift
//  ChatApp
//
//  Created by Sven Forstner on 25.08.16.
//  Copyright © 2016 Sven Forstner. All rights reserved.
//

import UIKit
import Firebase

class ViewControllerLoggedIn: UIViewController {
    
    var nsUserDefaults = systemVars.userUid

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if FIRAuth.auth() != nil {
            print("hello again")
        }
        
        print("user uid \(nsUserDefaults)")

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
    @IBAction func btnLogOut(sender: AnyObject) {
        do {
            try! FIRAuth.auth()?.signOut()
            let vc = self.storyboard?.instantiateViewControllerWithIdentifier("storyboardLogIn") as! ViewControllerLogIn
            self.showViewController(vc, sender: vc)
            
            systemVars.loggedInStatus = false
            
            print("logged in : \(systemVars.loggedInStatus)")
        }
    }

}
