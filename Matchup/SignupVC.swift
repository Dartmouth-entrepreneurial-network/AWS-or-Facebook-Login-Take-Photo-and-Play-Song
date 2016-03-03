//
//  SignupVC.swift
//  Matchup
//
//  Created by Randall Reynolds on 2/27/16.
//  Copyright © 2016 Randall Andrew Sam Sam. All rights reserved.
//

import UIKit

class SignupVC: UIViewController {
    
    
    /* https://github.com/rwreynol/mysql_server */
    
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
        
        // Send data to the server site
        let myUrl = NSURL(string: "https://github.com/rwreynol/mysql_server/userRegistration.php");
        //let myUrl = NSURL(string: "http://www.swiftdeveloperblog.com/http-post-example-script/");
        //let myUrl = NSURL(string: "/Users/randallreynolds/userRegistation.php");
        
        //"http://www.swiftdeveloperblog.com/http-post-example-script/"
        let request = NSMutableURLRequest(URL:myUrl!);
        request.HTTPMethod="POST";
        
        let postString = "email=\(userEmail)&password=\(userPassword)";
        //let postString = "firstName=James&lastName=Bond";
        print(postString);
        
        request.HTTPBody = postString.dataUsingEncoding(NSUTF8StringEncoding);
        
        // There is a video that goes through the below code that I should look at.
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request){
            data, response, error in
            
            if error != nil {
                print("error=\(error)")
                return
            }
            
            print("****** response =\(response)");
            
            do {
                let json = try NSJSONSerialization.JSONObjectWithData(data!, options: .MutableContainers) as? NSDictionary
                
                if let parseJSON = json {
                    
                    /*
                    let firstNameValue = parseJSON["firstName"] as? String
                    print("firstNameValue: \(firstNameValue)");
                    */
                    
                    let resultValue = parseJSON["status"] as? String
                    print("result: \(resultValue)")
                    
                    var isUserRegistered:Bool = false;
                    if (resultValue=="Success") { isUserRegistered = true; }
                    
                    var messageToDisplay:String = parseJSON["message"] as! String;
                    if (isUserRegistered)
                    {
                        messageToDisplay = parseJSON["message"] as! String;
                    }
                    
                    dispatch_async(dispatch_get_main_queue(), {
                        
                        // Display alert message with confirmation
                        let myAlert = UIAlertController(title:"Alert",message:messageToDisplay,preferredStyle: UIAlertControllerStyle.Alert);
                        
                        let okAction = UIAlertAction(title:"Ok",style: UIAlertActionStyle.Default){action in
                            self.dismissViewControllerAnimated(true, completion: nil);
                        }
                        myAlert.addAction(okAction);
                        self.presentViewController(myAlert, animated: true, completion: nil);
                    });
                    
                }
            } catch let error as NSError {
                print("**** ERROR ****")
                print(error);
                print("**** ERROR ****")
            }
        }
        
        task.resume();
        
        
        /*
        
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

        */

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
