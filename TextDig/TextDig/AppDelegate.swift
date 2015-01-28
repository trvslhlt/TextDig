//
//  AppDelegate.swift
//  TextDig
//
//  Created by trvslhlt on 1/18/15.
//  Copyright (c) 2015 travis holt. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  
  var window: UIWindow?
  
//  let cognitoAccountId = "Your-AccountID"
//  let cognitoIdentityPoolId = "Your-PoolID"
//  let cognitoUnauthRoleArn = "Your-RoleUnauth"
//  let snsPlatformApplicationArn = "Your-Platform-Applicatoin-ARN"
//  let mobileAnalyticsAppId = "Your-MobileAnalytics-AppId" 
  
  func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
    self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
    // Override point for customization after application launch.
    self.window!.backgroundColor = UIColor.whiteColor()
    self.window!.makeKeyAndVisible()
    let rootVC = HomeVC()
    let rootNavVC = UINavigationController(rootViewController: rootVC)
    self.window?.rootViewController = rootNavVC
    
    TDDocumentManager.copyDB()
    
    provideAWSCredentials()
    retrieveCognitoIDAndAWSCredentials()
    
    return true
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
  }
  
  func applicationWillTerminate(application: UIApplication) {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
  }
  
  
  func provideAWSCredentials() {
    let credentialsProvider = AWSCognitoCredentialsProvider.credentialsWithRegionType(AWSRegionType.USEast1, identityPoolId: "us-east-1:bef293eb-ade6-4a41-bea4-0b008db55bd8")
    let configuration = AWSServiceConfiguration(region: AWSRegionType.USEast1, credentialsProvider: credentialsProvider)
    AWSServiceManager.defaultServiceManager().setDefaultServiceConfiguration(configuration)
  }

  func retrieveCognitoIDAndAWSCredentials() {
//    // Retrieve your cognito ID.
//    NSString *cognitoId = credentialsProvider.identityId;
//    // create a configuration that uses the provider
//    AWSServiceConfiguration *configuration = [AWSServiceConfiguration configurationWithRegion:AWSRegionUSEast1
//      provider:credentialsProvider];
//    // get a client with the specified config
//    AWSDynamoDB *dynamoDB = [[AWSDynamoDB new] initWithConfiguration:configuration];
  }
}












