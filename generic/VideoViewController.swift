//
//  VideoViewController.swift
//  generic
//
//  Created by Samuel Putnam on 4/14/16.
//  Copyright © 2016 Randall Andrew Sam Sam. All rights reserved.
//

import MediaPlayer
import UIKit

class VideoViewController: UIViewController{
var genericvideo = NSURL(fileURLWithPath:NSBundle.mainBundle().pathForResource("videoviewdemo", ofType: "mp4")!)

    @IBAction func Hometapped(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil);
    }
    
var MoviePlayer = MPMoviePlayerController()
@IBAction func playVideo(){
MoviePlayer = MPMoviePlayerController(contentURL:genericvideo)
//MoviePlayer.setFullscreen(true, animated: true)
MoviePlayer.prepareToPlay()
MoviePlayer.view.frame = CGRectMake(0,0,320,320)
view.addSubview(MoviePlayer.view)
MoviePlayer.play()
}
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        // a comment
    }
    
}