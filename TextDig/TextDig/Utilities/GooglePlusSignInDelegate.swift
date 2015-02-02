//
//  GooglePlusSignInDelegate.swift
//  TextDig
//
//  Created by trvslhlt on 2/1/15.
//  Copyright (c) 2015 travis holt. All rights reserved.
//

import UIKit

class GooglePlusSignInDelegate: NSObject, GPPSignInDelegate {
  
  var appDelegate: AppDelegate { get { return UIApplication.sharedApplication().delegate as AppDelegate } }
  var signIn: GPPSignIn {
    get {
      let si = GPPSignIn.sharedInstance()
      si.shouldFetchGooglePlusUser = true
      si.clientID = kClientId
      si.scopes = ["profile"]
      si.delegate = self
      si.shouldFetchGoogleUserEmail = true
      return si
    }
  }
  var afterSuccessfulLogin: (() -> ())?
  var afterUnsuccessfulLogin: (() -> ())?
  var afterLogout: ((NSError!) -> ())?
  
  class var sharedInstance: GooglePlusSignInDelegate {
    struct Singleton {
      static let instance = GooglePlusSignInDelegate()
    }
    return Singleton.instance
  }
  
  func isLoggedIn() -> Bool {
    return signIn.trySilentAuthentication()
  }
  
  func login() {
    signIn.authenticate()
  }
  
  func logout() {
    signIn.disconnect()
  }
  
  func getUserEmail() -> String {
    return signIn.userEmail ?? ""
  }
  
  // MARK: GPPSingInDelegate
  func finishedWithAuth(auth: GTMOAuth2Authentication!, error: NSError!) {
    if error != nil {
      self.afterUnsuccessfulLogin?()
    } else {
      if let idToken: AnyObject = auth.parameters["id_token"] {
        let providerKey = AWSCognitoLoginProviderKey.Google.rawValue
        appDelegate.credentialsProvider.logins = [providerKey: idToken]
        self.afterSuccessfulLogin?()
      }
    }
  }
  
  func didDisconnectWithError(error: NSError!) {
    self.afterLogout?(error)
  }
  
}