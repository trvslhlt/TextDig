//
//  TBVC.swift
//  TextDig
//
//  Created by trvslhlt on 1/19/15.
//  Copyright (c) 2015 travis holt. All rights reserved.
//

import UIKit

class TBVC: UIViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    NSNotificationCenter.defaultCenter().addObserver(self, selector: "deviceOrientationChanged", name: UIDeviceOrientationDidChangeNotification, object: nil)
  }
  
  func deviceOrientationChanged() {
    //optional override in subclasses
  }
  
}
