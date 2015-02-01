//
//  TDActivityIndicatorView.swift
//  TextDig
//
//  Created by trvslhlt on 2/1/15.
//  Copyright (c) 2015 travis holt. All rights reserved.
//

import UIKit

class TDActivityIndicatorView: UIActivityIndicatorView {
  
  func start() {
    if let sv = self.superview {
      sv.bringSubviewToFront(self)
      self.startAnimating()
    }
  }
  
  func stop() {
    if let sv = self.superview {
      sv.sendSubviewToBack(self)
      self.stopAnimating()
    }
  }

}
