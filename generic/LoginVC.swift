//
//  LoginVC.swift
//  generic
//
//  Created by Randall Reynolds on 3/1/16.
//  Copyright © 2016 Randall Andrew Sam Sam. All rights reserved.
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
        
        if (FBSDKAccessToken.currentAccessToken() != nil)
        {
            // User is already logged in, do work such as go to next view controller.
        }
        else
        {
            let loginButton : FBSDKLoginButton = FBSDKLoginButton()
            self.view.addSubview(loginButton)
            loginButton.center = self.view.center
            loginButton.readPermissions = ["public_profile", "email", "user_friends"]
            loginButton.delegate = self
        }
    }
    
    func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError!) {
        if ((error) != nil) {
            // Process error
        }
        else if result.isCancelled {
            // Handle cancellations
        }
        else {
            // Navigate to other view
        }
    }
    
    func loginButtonDidLogOut(loginButton: FBSDKLoginButton!) {
        // Something to be written later
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func signinTapped(sender: AnyObject) {
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
