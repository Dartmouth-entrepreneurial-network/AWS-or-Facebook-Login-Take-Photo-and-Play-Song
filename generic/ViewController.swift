//
//  ViewController.swift
//  generic
//
//  Created by Randall Reynolds on 2/27/16.
//  Copyright © 2016 Randall Andrew Sam Sam. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    var helloButton: UIButton = UIButton (frame: CGRect(x: 0, y: 0, width: 100, height: 25))
    var imageFromSource = UIImagePickerController()
    @IBOutlet var imageView : UIImageView!
    @IBAction func captureImage(){
    imageFromSource.delegate = self
    imageFromSource.allowsEditing = false
    
  
      
        
        
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera){
            
            imageFromSource.sourceType = UIImagePickerControllerSourceType.Camera
            
            
        }
        else {
            imageFromSource.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        }
        self.presentViewController(imageFromSource,animated: true, completion:nil)
        
        
        
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        var temp : UIImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        imageView.image = temp
        self.dismissViewControllerAnimated(true, completion: {})
    }
    
    func showMessage(){
        var msgTitle : String = "Hello World"
        var messageString : String = "Thanks for the visit!"
        
        var alert : UIAlertView = UIAlertView()
        alert.title = msgTitle
        alert.message = messageString
        alert.addButtonWithTitle("OK")
        alert.show()
    }
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var loginButton: FBSDKLoginButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        helloButton.setTitle("A button", forState:UIControlState.Normal)
        helloButton.backgroundColor = UIColor.blueColor()
        helloButton.addTarget(self, action: "showMessage", forControlEvents: UIControlEvents.TouchUpInside)
        helloButton.center = CGPointMake(160, 300)
        view.addSubview(helloButton)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        let isUserLoggedIn = NSUserDefaults.standardUserDefaults().boolForKey("isUserLoggedIn");
        
        if (!isUserLoggedIn)
        {
            self.performSegueWithIdentifier("goto_login", sender: self);
        }
    }


    @IBAction func logoutTapped(sender: UIButton) {
        
        NSUserDefaults.standardUserDefaults().setBool(false,forKey:"isUserLoggedIn");
        NSUserDefaults.standardUserDefaults().synchronize();
        self.performSegueWithIdentifier("goto_login", sender: self)
}
}
