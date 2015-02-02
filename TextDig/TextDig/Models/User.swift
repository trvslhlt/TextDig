//
//  User.swift
//  TextDig
//
//  Created by trvslhlt on 2/1/15.
//  Copyright (c) 2015 travis holt. All rights reserved.
//

import UIKit

class User: Model {
  
  var loginDelegate: GooglePlusSignInDelegate { get { return GooglePlusSignInDelegate.sharedInstance } }
  var beginLogin: (() -> ())?
  var endLogin: ((success: Bool) -> ())?
  var beginLogout: (() -> ())?
  var endLogout: ((success: Bool) -> ())?
  var email: String { get { return loginDelegate.getUserEmail() } }
  var messages: [Message] = [Message]()
  
  func isLoggedIn() -> Bool {
    self.beginLogin?()
    let ili = loginDelegate.isLoggedIn()
    self.endLogin?(success: ili)
    return ili
  }
  
  func login() {
    self.beginLogin?()
    if loginDelegate.isLoggedIn() {
      self.endLogin?(success: true)
      return
    }
    loginDelegate.afterSuccessfulLogin = {
      println("\(self.email)")
      self.endLogin?(success: true)
      return
    }
    loginDelegate.afterUnsuccessfulLogin = {
      self.endLogin?(success: false)
      return
    }
    loginDelegate.login()
  }
  
  func logout() {
    beginLogout?()
    loginDelegate.afterLogout = { error in
      if error == nil {
        self.endLogout?(success: true)
      } else {
        self.endLogout?(success: false)
      }
    }
    loginDelegate.logout()
  }
  
}
