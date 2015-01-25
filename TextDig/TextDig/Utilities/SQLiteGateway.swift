//
//  SQLiteGateway.swift
//  TextDig
//
//  Created by trvslhlt on 1/25/15.
//  Copyright (c) 2015 travis holt. All rights reserved.
//

import UIKit

class SQLiteGateway: NSObject, DataSource {
  
  // MARK: Contacts
  private class func firstNameKey() -> String { return "First" }
  private class func lastNameKey() -> String { return "Last" }
  private class func contactIDKey() -> String { return "ContactID" }
  private class func uniqueIDKey() -> String { return "UniqueID" }
  class func getContacts() -> [Contact] {
    let (resultSet, err) = SD.executeQuery("SELECT * FROM contacts")
    if err != nil { return [Contact]() }
    return resultSet.map({ self.instanceFromRow($0) }).filter({ $0 != nil }).map({ $0! })
  }
  class func instanceFromRow(row: SwiftData.SDRow) -> Contact? {
    let f = row[firstNameKey()]?.asString()
    let l = row[lastNameKey()]?.asString()
    let c = row[contactIDKey()]?.asInt()
    let u = row[uniqueIDKey()]?.asString()
    switch (c,u) {
    case let (.Some(c), .Some(u)):
      return Contact(firstName: f, lastName: l, contactID: c, uniqueID: u)
    default:
      return nil
    }
  }
  
}
