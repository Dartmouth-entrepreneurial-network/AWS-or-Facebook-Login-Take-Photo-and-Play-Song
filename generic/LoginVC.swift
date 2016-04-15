//
//  LoginVC.swift
//  generic
//
//  Created by Randall Reynolds on 3/1/16.
//  Copyright © 2016 Randall Sam Sam. All rights reserved.
//

import UIKit
//import AWSCore

class LoginVC: UIViewController, FBSDKLoginButtonDelegate {

    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var loginButton: FBSDKLoginButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        // a comment
        
        if (FBSDKAccessToken.currentAccessToken() != nil)
        {
            print("not nil")
            // User is already logged in, do work, such as go to next view controller.
        }
        else
        {
        print("nil")
        }
    
        let loginButton : FBSDKLoginButton = FBSDKLoginButton()

            self.view.addSubview(loginButton)

            loginButton.center = self.view.center

            loginButton.readPermissions = ["public_profile", "email", "user_friends"]

            loginButton.delegate = self

    }
    
    func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError!) {
        if (error == nil) {
            // Process error
            
            print("user is logged in")
            self.dismissViewControllerAnimated(true, completion: nil)
            NSUserDefaults.standardUserDefaults().setBool(true, forKey:"isUserLoggedIn");
            NSUserDefaults.standardUserDefaults().synchronize();
        }
   
        else {
            // Navigate to other view
            print("error")
            print(error.localizedDescription)
        }
    }
    
    func loginButtonDidLogOut(loginButton: FBSDKLoginButton!) {
        print("User Logged Out")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    @IBAction func LoginTapped(sender: AnyObject) {
        let userEmail = txtEmail.text;
        let userPassword = txtPassword.text;
        
        let syncClient = AWSCognito.defaultCognito()
        let dataset = syncClient.openOrCreateDataset("Users")
        //dataset.synchronize()
        let records = dataset.getAll()
        let keys = records.keys;
        
        let isUser  = keys.contains(userEmail!);
        
        
        //if (record,, in records) {
        if (isUser) {
            let userPasswordStored = dataset.stringForKey(userEmail!)
            
            if (userPassword == userPasswordStored)
            {
                NSUserDefaults.standardUserDefaults().setBool(true, forKey:"isUserLoggedIn");
                NSUserDefaults.standardUserDefaults().synchronize();
                
                self.dismissViewControllerAnimated(true, completion: nil)
            }
        }
        //}

    }
}
