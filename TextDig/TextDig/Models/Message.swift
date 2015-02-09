//
//  Message.swift
//  TextDig
//
//  Created by trvslhlt on 1/25/15.
//  Copyright (c) 2015 travis holt. All rights reserved.
//

import UIKit

class Message: Model, NSCoding {
  
  class var toMeKey: String { return "toMe" }
  class var textKey: String { return "text" }
  class var timeKey: String { return "time" }
  class var uniqueIDKey: String { return "uniqueID" }
  class var attachmentIDKey: String { return "attachmentID" }
  
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
  
  required init(coder aDecoder: NSCoder) {
    self.toMe = aDecoder.decodeBoolForKey(Message.toMeKey) as Bool
    self.text = aDecoder.decodeObjectForKey(Message.textKey) as String
    self.time = aDecoder.decodeObjectForKey(Message.timeKey) as NSDate
    self.uniqueID = aDecoder.decodeObjectForKey(Message.uniqueIDKey) as String
    let a = aDecoder.decodeIntForKey(Message.attachmentIDKey) as Int32 //returns 0 if the key does not exist
    self.attachmentID = a == 0 ? nil : Int(a)
  }
  
  func encodeWithCoder(aCoder: NSCoder) {
    aCoder.encodeBool(self.toMe, forKey: Message.toMeKey)
    aCoder.encodeObject(self.text, forKey: Message.textKey)
    aCoder.encodeObject(self.time, forKey: Message.timeKey)
    aCoder.encodeObject(self.uniqueID, forKey: Message.uniqueIDKey)
    if let a = self.attachmentID { aCoder.encodeInt(Int32(a), forKey: Message.attachmentIDKey) }
  }
}










