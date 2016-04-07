//
//  AppDelegate.swift
//  generic
//
//  Created by Randall Reynolds on 2/27/16.
//  Copyright © 2016 Randall Andrew Sam Sam. All rights reserved.
//
//import AWSCore
import UIKit
//import FBSDKCoreKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    /* + (void)initialize
     {
     // Nib files require the type to have been loaded before they can do the wireup successfully.
     // http://stackoverflow.com/questions/1725881/unknown-class-myclass-in-interface-builder-file-error-at-runtime
     [FBSDKLoginButton class];
     [FBSDKProfilePictureView class];
     [FBSDKSendButton class];
     [FBSDKShareButton class];
     }*/
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        //App launch code
        FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)
        //AWS default service configuration
        let credentialsProvider = AWSCognitoCredentialsProvider(regionType: AWSRegionType.USEast1, identityPoolId: "us-east-1:8ba306b8-9edb-441b-881b-3be159e82a44")
        //other parameters that may be added into AWSCognitoCredentialsProvider
        //accountId: "098342329016"
        //unauthRoleArn: "arn:aws:iam::098342329016:role/Cognito_MatchupUnauth_Role", authRoleArn: "arn:aws:iam:098342329016:role/Cognito_MatchupAuth_Role"
        
        let defaultServiceConfiguration = AWSServiceConfiguration(
            region: AWSRegionType.USEast1, credentialsProvider: credentialsProvider)
        
        AWSServiceManager.defaultServiceManager().defaultServiceConfiguration = defaultServiceConfiguration
        
        
        return true
    }
    
    /* - (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
     BOOL handled = [[FBSDKApplicationDelegate sharedInstance] application:application
     openURL:url
     sourceApplication:sourceApplication
     annotation:annotation
     ];
     // Add any custom logic here.
     return handled; */
    
    func application(application: UIApplication,
                     openURL url: NSURL,
                             sourceApplication: String?,
                             annotation: AnyObject) -> Bool {
        //Even though the Facebook SDK can make this determinitaion on its own,
        //let's make sure that the facebook SDK only sees urls intended for it,
        let isFacebookURL = url.scheme.hasPrefix("fb\(FBSDKSettings.appID())") && url.host == "authorize"
        if isFacebookURL {
        return FBSDKApplicationDelegate.sharedInstance().application(
            application,
            openURL: url,
            sourceApplication: sourceApplication,
            annotation: annotation)
        }
        return false
    }
    
    
    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        FBSDKAppEvents.activateApp()
    }
    
    //Here's the facebook login code, have your login procedure call this:
    
    let facebookReadPermissions = ["public_profile", "email", "user_friends"]
    
    func loginToFacebookWithSuccess(successBlock: () -> (), andFailure failureBlock: (NSError?) -> ()) {
        
        if FBSDKAccessToken.currentAccessToken() != nil {
            //For debugging, when we want to ensure that facebook login always happens
            //FBSDKLoginManager().logOut()
            //Otherwise do:
            return
        }
        
        FBSDKLoginManager().logInWithReadPermissions(self.facebookReadPermissions, handler: { (result:FBSDKLoginManagerLoginResult!, error:NSError!) -> Void in
            if error != nil {
                //According to Facebook:
                //Errors will rarely occur in the typical login flow because the login dialog
                //presented by Facebook via single sign on will guide the users to resolve any errors.
                
                // Process error
                FBSDKLoginManager().logOut()
                failureBlock(error)
            } else if result.isCancelled {
                // Handle cancellations
                FBSDKLoginManager().logOut()
                failureBlock(nil)
            } else {
                /*
                // If you ask for multiple permissions at once, you
                // should check if specific permissions missing
                var allPermsGranted = true
                //result.grantedPermissions returns an array of _NSCFString pointers
                let grantedPermissions = result.grantedPermissions.map({"\($0)"})//.allObjects.map( {"\($0)"} )
                for permission in self.facebookReadPermissions {
                    if !contains(grantedPermissions, permission) {
                        allPermsGranted = false
                        break
                    }
                }
                if allPermsGranted {
                    // Do work
                    let fbToken = result.token.tokenString
                    let fbUserID = result.token.userID
                    successBlock()
                } else {
                    //The user did not grant all permissions requested
                    //Discover which permissions are granted
                    //and if you can live without the declined ones
                    failureBlock((nil))
                }*/
            }
        })
    
    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    
}
}
