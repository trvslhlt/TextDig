//
//  Contact.swift
//  TextDig
//
//  Created by trvslhlt on 1/24/15.
//  Copyright (c) 2015 travis holt. All rights reserved.
//

import UIKit

class Contact: Model, NSCoding {
  
  let firstName: String?
  let lastName: String?
  let contactID: Int
  let uniqueID: String
  
  private class var firstNameKey: String { return "firstName" }
  private class var lastNameKey: String { return "lastName" }
  private class var contactIDKey: String { return "contactID" }
  private class var uniqueIDKey: String { return "uniqueID" }
  
  required init(coder aDecoder: NSCoder) {
    self.firstName = aDecoder.decodeObjectForKey(Contact.firstNameKey) as? String
    self.lastName = aDecoder.decodeObjectForKey(Contact.lastNameKey) as? String
    self.contactID = aDecoder.decodeObjectForKey(Contact.contactIDKey) as Int
    self.uniqueID = aDecoder.decodeObjectForKey(Contact.uniqueIDKey) as String
  }
  
  func encodeWithCoder(aCoder: NSCoder) {
    if let firstName = self.firstName { aCoder.encodeObject(firstName, forKey: Contact.firstNameKey) }
    if let lastName = self.lastName { aCoder.encodeObject(lastName, forKey: Contact.lastNameKey) }
    aCoder.encodeObject(self.contactID, forKey: Contact.contactIDKey)
    aCoder.encodeObject(self.uniqueID, forKey: Contact.uniqueIDKey)
  }
  
  init(firstName: String?, lastName: String?, contactID: Int, uniqueID: String) {
    self.firstName = firstName
    self.lastName = lastName
    self.contactID = contactID
    self.uniqueID = uniqueID
    super.init()
  }
  
}








