//
//  ViewController.swift
//  generic
//
//  Created by Randall Reynolds on 2/27/16.
//  Copyright © 2016 Randall Andrew Sam Sam. All rights reserved.

///Users/samuelputnam/Documents/Folder/songs/calm.mp3

import UIKit
import AVFoundation

class ViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    var helloButton: UIButton = UIButton (frame: CGRect(x: 0, y: 0, width: 300, height: 35))
    var helloButton2: UIButton = UIButton (frame: CGRect(x: 0, y: 0, width: 300, height: 35))
    
    var Player = AVAudioPlayer()
    var nowPlaying = false
    var timer:NSTimer!
    
    
    
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
    
    func UIColorFromRGB(rgbValue: UInt) -> UIColor {
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    func showAlertController() {
        
        let title = "Hello World!"
        //Localized strings can be used with alertview too of course
        let message = NSLocalizedString("Are you doing well?", comment: "Yes")
        let cancelButtonTitle = NSLocalizedString("No", comment: "")
        let otherButtonTitle = NSLocalizedString("Yes", comment: "")
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .Alert)
        let cancelAction = UIAlertAction(title: cancelButtonTitle, style: .Cancel){action in
            NSLog("User not doing well today")
    }
        let otherAction = UIAlertAction(title: otherButtonTitle, style: .Default){action in
            NSLog("User feeling good")
    }
    
    alertController.addAction(cancelAction)
    alertController.addAction(otherAction)
    presentViewController(alertController, animated: true, completion: nil)
    
}

    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var loginButton: FBSDKLoginButton!
    
    @IBAction func pauseAction(sender: AnyObject){
        if nowPlaying {
            Player.pause()
            nowPlaying = false
        }
        }
    
    @IBOutlet weak var timeLabel: UILabel!
    
    let musicPath = NSBundle.mainBundle().pathForResource("calm", ofType: "mp3")
  
    
    @IBAction func playAction(sender: AnyObject){
   
        
        if !nowPlaying{
                Player.play()
                nowPlaying = true
                 timer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: "displayCurrentTime", userInfo: nil, repeats: true)
                
            }
            
        }
       

    func displayCurrentTime() {
        var elapsedTime = Int(Player.currentTime)
        var minutes = elapsedTime/60
        var seconds = elapsedTime  - (minutes * 60)
        timeLabel.text = NSString(format: "%02d:%02d", minutes,seconds) as String
    }
 
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
         let url = NSURL(fileURLWithPath: musicPath!)
        do{
            Player = try AVAudioPlayer(contentsOfURL: url)
        }
        catch{
        }
        
        helloButton.setTitle("An AlertView button", forState:UIControlState.Normal)
        helloButton.backgroundColor = UIColorFromRGB(0x007AFF)
        helloButton.addTarget(self, action: "showMessage", forControlEvents: UIControlEvents.TouchUpInside)
        helloButton.center = CGPointMake(185, 500)
        view.addSubview(helloButton)
        helloButton2.setTitle("An AlertController button", forState:UIControlState.Normal)
        helloButton2.backgroundColor = UIColorFromRGB(0x007AFF)
        helloButton2.addTarget(self, action: "showAlertController", forControlEvents: UIControlEvents.TouchUpInside)
        helloButton2.center = CGPointMake(185, 550)
        view.addSubview(helloButton2)
        
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
