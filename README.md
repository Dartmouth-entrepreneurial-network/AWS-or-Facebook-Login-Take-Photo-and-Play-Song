# generic
Generic app login

This is a generic Swift 2.2 app that stores a user email and password on an AWS Cognito backend at sign up and upon attempted login verifies that the user email and password entered exist in the database before logging the user in.

The app is confirmed functional for these specifications:

Xcode: Version 7.2.1 (7C1002)
       Version 7.3 (7D175)

iOS Simulator: iPhone 6

USEast (N. Virginia) region

pod install

open generic.xcworkspace

Get started with the Facebook SDK:
https://developers.facebook.com/docs/ios/getting-started/

Do add SDK directory to framework search paths 
