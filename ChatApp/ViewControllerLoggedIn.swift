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
    
    var ref = FIRDatabaseReference()
    
    @IBOutlet weak var userNameLabel: UILabel!
    
    var userUid = systemVars.userUid
    var message = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Chat"
        
        self.ref = rootRef
        userStates()
        print("user : \(userUid)")

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
    
    func userStates() {
        
        
        
        if let user = FIRAuth.auth()?.currentUser {
            
            let name = user.displayName
            let email = user.email
            let photoUrl = user.photoURL
            let uid = user.uid
            
            userNameLabel.text = name
            
            print("user dates : \(name, email, photoUrl, uid)")
            
        } else {
            
        }
        
        
    }
    
    
    

    
    
    @IBAction func btnLogOut(_ sender: AnyObject) {
        do {
            try! FIRAuth.auth()?.signOut()
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "storyboardLogIn") as! ViewControllerLogIn
            self.show(vc, sender: vc)
            
            systemVars.loggedInStatus = false
            
            print("logged in : \(systemVars.loggedInStatus)")
        }
    }

}
