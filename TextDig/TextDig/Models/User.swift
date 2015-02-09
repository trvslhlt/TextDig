//
//  User.swift
//  TextDig
//
//  Created by trvslhlt on 2/1/15.
//  Copyright (c) 2015 travis holt. All rights reserved.
//

import UIKit

class User: Model, NSCoding {
  
  class var messagesKey: String { return "messages" }

  var loginDelegate: GooglePlusSignInDelegate { get { return GooglePlusSignInDelegate.sharedInstance } }
  var beginLogin: (() -> ())?
  var endLogin: ((success: Bool) -> ())?
  var beginLogout: (() -> ())?
  var endLogout: ((success: Bool) -> ())?
  var email: String { get { return loginDelegate.getUserEmail() } }
  var messages: [Message] = [Message]() {
    didSet {
      DAO.sharedInstance.save()
    }
  }
  
  override init() {
    super.init()
  }
  
  required init(coder aDecoder: NSCoder) {
    if let m = aDecoder.decodeObjectForKey(User.messagesKey) as? [Message] {
      self.messages = m
    }
  }
  
  func encodeWithCoder(aCoder: NSCoder) {
    aCoder.encodeObject(self.messages, forKey: User.messagesKey)
  }
  
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
