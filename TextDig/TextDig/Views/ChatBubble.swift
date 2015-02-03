//
//  ChatBubble.swift
//  TextDig
//
//  Created by trvslhlt on 2/3/15.
//  Copyright (c) 2015 travis holt. All rights reserved.
//

import UIKit

class ChatBubble: UIView {

  override func awakeAfterUsingCoder(aDecoder: NSCoder) -> AnyObject? {
    super.awakeAfterUsingCoder(aDecoder)
    setup()
    return self
  }
  
  func setup() {
    backgroundColor = UIColor.greenColor()
  }

}
