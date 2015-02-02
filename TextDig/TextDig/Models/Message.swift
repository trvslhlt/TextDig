//
//  Message.swift
//  TextDig
//
//  Created by trvslhlt on 1/25/15.
//  Copyright (c) 2015 travis holt. All rights reserved.
//

import UIKit

class Message: Model {
  
  let toMe: Bool
  let text: String
  let time: NSDate
  let uniqueID: String
  let attachmentID: Int?
  
  init(toMe: Bool, text: String, time: NSDate, uniqueID: String, attachmentID: Int?) {
    self.toMe = toMe
    self.text = text
    self.time = time
    self.uniqueID = uniqueID
    self.attachmentID = attachmentID
    super.init()
  }
}
