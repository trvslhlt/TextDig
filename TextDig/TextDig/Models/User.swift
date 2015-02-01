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
  var endLogin: ((successful: Bool) -> ())?
  var beginLogout: (() -> ())?
  var endLogout: ((successful: Bool) -> ())?
  
  func isLoggedIn() -> Bool {
    self.beginLogin?()
    let ili = loginDelegate.isLoggedIn()
    self.endLogin?(successful: ili)
    return ili
  }
  
  func login() {
    self.beginLogin?()
    if loginDelegate.isLoggedIn() {
      self.endLogin?(successful: true)
      return
    }
    loginDelegate.afterSuccessfulLogin = {
      self.endLogin?(successful: true)
      return
    }
    loginDelegate.afterUnsuccessfulLogin = {
      self.endLogin?(successful: false)
      return
    }
    loginDelegate.login()
  }
  
  func logout() {
    beginLogout?()
    loginDelegate.afterLogout = { error in
      if error == nil {
        self.endLogout?(successful: true)
      } else {
        self.endLogout?(successful: false)
      }
    }
    loginDelegate.logout()
  }
  
}
