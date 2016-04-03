//
//  LoginVC.swift
//  Matchup
//
//  Created by Randall Reynolds on 3/1/16.
//  Copyright © 2016 Randall Andrew Sam Sam. All rights reserved.
//

import UIKit
//import AWSCore

class LoginVC: UIViewController {

    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
