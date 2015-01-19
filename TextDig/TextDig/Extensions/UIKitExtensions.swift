//
//  UIKitExtensions.swift
//  TextDig
//
//  Created by trvslhlt on 1/19/15.
//  Copyright (c) 2015 travis holt. All rights reserved.
//

import UIKit

// MARK:
extension UIColor {
  
  class func rgb255(r: CGFloat, g: CGFloat, b: CGFloat) -> UIColor {
    return UIColor(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: 1.0)
  }
  
  class func tdLightDefault() -> UIColor {
    return UIColor.rgb255(253, g: 161, b: 109)
  }
}
