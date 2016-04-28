//
//  SignupVC.swift
//  generic
//
//  Created by Randall Reynolds on 2/27/16.
//  Copyright © 2016 Randall Sam Sam. All rights reserved.
//

//import AWSCore
import UIKit


class SignupVC: UIViewController {
    
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtConfirmPassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        // a comment
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
        
        // Send data to the server site
        // Use AWS to do this
        // First, Initialize the Cognito Sync client
        let syncClient = AWSCognito.defaultCognito()
        let dataset = syncClient.openOrCreateDataset("Users")
        dataset.setString(userPassword, forKey:userEmail)
        dataset.synchronize().continueWithBlock {(task: AWSTask!) -> AnyObject! in
            // Your handler code here
            return nil
            
        }
        
        //Print the email and password that the user entered to the console
        let postString = "email=\(userEmail)&password=\(userPassword)";
        print(postString);
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
