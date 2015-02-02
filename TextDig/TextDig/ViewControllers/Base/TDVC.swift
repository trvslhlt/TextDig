//
//  TBVC.swift
//  TextDig
//
//  Created by trvslhlt on 1/19/15.
//  Copyright (c) 2015 travis holt. All rights reserved.
//

import UIKit

class TDVC: UIViewController {
  
  var appDelegate: AppDelegate { get { return UIApplication.sharedApplication().delegate as AppDelegate } }
  let dao = DAO.sharedInstance
  var user: User { get { return self.dao.user } }
  lazy var activityIndicator: TDActivityIndicatorView = {
    let v = TDActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.WhiteLarge)
    self.view.addSubview(v)
    v.autoPinEdgesToSuperviewMargins()
    self.view.sendSubviewToBack(v)
    return v
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configureNotifications()
  }
  
  override func viewDidAppear(animated: Bool) {
    super.viewDidAppear(animated)
    login()
  }
  
  // MARK: User Management
  func showLoginVC() {
    if let vc = self as? LoginVC { return }
    let loginVC = LoginVC()
    loginVC.modalPresentationStyle = UIModalPresentationStyle.OverCurrentContext
    self.presentViewController(loginVC, animated: true, completion: nil)
  }
  
  func login() {
    user.beginLogin = {
      self.activityIndicator.start()
      return
    }
    user.endLogin = { success in
      self.activityIndicator.stop()
    }
    if !user.isLoggedIn() {
      showLoginVC()
    }
  }
  
  func logout() {
    user.beginLogout = { self.activityIndicator.start() }
    user.endLogout = { success in
      self.activityIndicator.stop()
      if !success {
        //
      } else {
        self.showLoginVC()
      }
    }
    user.logout()
  }
  
  // MARK: NSNotifications
  func configureNotifications() {
    NSNotificationCenter.defaultCenter().addObserver(self, selector: "deviceOrientationChanged", name: UIDeviceOrientationDidChangeNotification, object: nil)
  }
  func deviceOrientationChanged() {}
}
