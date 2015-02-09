//
//  LoginVC.swift
//  TextDig
//
//  Created by trvslhlt on 2/1/15.
//  Copyright (c) 2015 travis holt. All rights reserved.
//

import UIKit

class LoginVC: TDVC, UIViewControllerTransitioningDelegate {
  
  required init() {
    super.init(nibName: "LoginVC", bundle: nil)
  }

  required init(coder aDecoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
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
  
  func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
    let transitioning = StandardModalTransition()
    transitioning.presenting = true
    return transitioning
  }
  
  func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
    let transitioning = StandardModalTransition()
    transitioning.presenting = false
    return transitioning
  }
  
}
