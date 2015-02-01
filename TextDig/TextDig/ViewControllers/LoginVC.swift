//
//  LoginVC.swift
//  TextDig
//
//  Created by trvslhlt on 2/1/15.
//  Copyright (c) 2015 travis holt. All rights reserved.
//

import UIKit

class LoginVC: TDVC {
  
  override init() {
    super.init(nibName: "LoginVC", bundle: nil)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  // MARK: IBActions
  
  @IBAction func signInTapped(sender: AnyObject) {
    dao.user.beginLogin = { self.activityIndicator.startAnimating() }
    dao.user.endLogin = { successful in
      self.activityIndicator.stopAnimating()
      if successful {
        self.dismissViewControllerAnimated(true, completion: nil)
      }
    }
    dao.user.login()
  }
  
}
