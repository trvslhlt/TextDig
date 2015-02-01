//
//  DAO.swift
//  TextDig
//
//  Created by trvslhlt on 1/24/15.
//  Copyright (c) 2015 travis holt. All rights reserved.
//

import UIKit

protocol DataSource {
  class func getContacts() -> [Contact]
}

class DAO: Model {
  
  class var sharedInstance: DAO {
    struct Singleton {
      static let instance = DAO()
    }
    return Singleton.instance
  }
  
  lazy var contacts: [Contact] = {
    return SQLiteGateway.getContacts()
  }()
  
  lazy var user: User = {
    return User()
  }()

}
