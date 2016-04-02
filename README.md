# generic
Generic app login

This is a generic Swift 2.2 app that stores a user email and password on an AWS Cognito backend at sign up and upon attempted login verifies that the user email and password entered exist in the database before logging the user in.

The project target is titled Matchup because this organization, RandallAndrewSamSam, had designed a wireframe iOS app of this name.

The app is confirmed functional for these specifications:

Xcode: Version 7.2.1 (7C1002)
       Version 7.3 (7D175)

iOS Simulator: iPhone 6

USEast (N. Virginia) region

Podfile

source 'https://github.com/CocoaPods/Specs.git'

pod 'AWSCognito'

pod 'FBSDKCoreKit'

pod 'FBSDKLoginKit'

pod 'Bolts

pod 'AWSCore'

pod install

Get started with the Facebook SDK:
https://developers.facebook.com/docs/ios/getting-started/

Do add SDK directory to framework search paths 
