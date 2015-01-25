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

//  class func dataSource() -> DataSource.Protocol { return SQLiteGateway.self }
  
  lazy var contacts: [Contact] = {
    return SQLiteGateway.getContacts()
  }()

}
