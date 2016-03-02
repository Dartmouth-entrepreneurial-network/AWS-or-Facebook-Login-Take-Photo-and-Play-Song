//
//  SignupVC.swift
//  Matchup
//
//  Created by Randall Reynolds on 2/27/16.
//  Copyright © 2016 Randall Andrew Sam Sam. All rights reserved.
//

import UIKit

class SignupVC: UIViewController {
    
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtConfirmPassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


        
        
    @IBAction func registerButtonTapped(sender: AnyObject) {
        let userEmail = txtEmail.text;
        let userPassword = txtPassword.text;
        let userConfirmPassword = txtConfirmPassword.text;
        
        // Check for empty fields
        if ( (userEmail == nil) || (userPassword == nil) || (userConfirmPassword == nil) ||
            (userEmail == "") || (userPassword == "") || (userConfirmPassword == "") )
        {
            // Display alert message
            displayMyAlertMessage("All fields are required");
            
            return;
        }
        
        // Check if password match
        if (userPassword != userConfirmPassword)
        {
            // Display alert message
            displayMyAlertMessage("Passwords do not match");
            
            return;
        }
        
        // Store data
        NSUserDefaults.standardUserDefaults().setObject(userEmail,forKey:"userEmail");
        NSUserDefaults.standardUserDefaults().setObject(userPassword,forKey:"userPassword");
        NSUserDefaults.standardUserDefaults().synchronize();
        
        
        // Display alert message with confirmation
        let myAlert = UIAlertController(title:"Alert",message:"Sign up successful",preferredStyle: UIAlertControllerStyle.Alert);
        let okayAction = UIAlertAction(title:"Okay",style:UIAlertActionStyle.Default){ action in
            self.dismissViewControllerAnimated(true, completion: nil);
        }
        
        myAlert.addAction(okayAction);
        self.presentViewController(myAlert,animated:true,completion:nil);

    }
    
    func displayMyAlertMessage(userMessage:String) {
        let myAlert = UIAlertController(title:"Alert",message:userMessage,preferredStyle: UIAlertControllerStyle.Alert);
        
        let okayAction = UIAlertAction(title:"Okay",style:UIAlertActionStyle.Default,handler:nil);
        
        myAlert.addAction(okayAction);
        
        self.presentViewController(myAlert,animated:true,completion:nil);
        
    }
    
    @IBAction func alreadyHaveAccountTapped(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil);
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
