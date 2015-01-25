//
//  Contact.swift
//  TextDig
//
//  Created by trvslhlt on 1/24/15.
//  Copyright (c) 2015 travis holt. All rights reserved.
//

import UIKit

class Contact: Model {
  
  let firstName: String?
  let lastName: String?
  let contactID: Int
  let uniqueID: String
  
  init(firstName: String?, lastName: String?, contactID: Int, uniqueID: String) {
    self.firstName = firstName
    self.lastName = lastName
    self.contactID = contactID
    self.uniqueID = uniqueID
    super.init()
  }
  
}








