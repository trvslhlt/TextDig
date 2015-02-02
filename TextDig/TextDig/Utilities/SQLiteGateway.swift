//
//  SQLiteGateway.swift
//  TextDig
//
//  Created by trvslhlt on 1/25/15.
//  Copyright (c) 2015 travis holt. All rights reserved.
//

import UIKit

class SQLiteGateway: NSObject, DataSource {
  
  typealias Row = SwiftData.SDRow
  typealias QueryResult = (Row, Int?)
  enum Table: String {
    case Messages = "messages"
    case Contacts = "contacts"
  }
  

  
  
  
  
  
  class func getContactIDForName(name: String) -> Int? {
    let qr = SD.executeQuery("SELECT ContactID from \(Table.Contacts.rawValue) WHERE First = ?", withArgs: [name])
    if qr.error != nil { return nil }
    if qr.result.count != 0 {
      if let c = qr.result[0][contactIDKey()]?.asInt() {
        return c
      }
    }
    return nil
  }
  
  class func getUniqueIDsForContactID(contactID: Int) -> [String] {
    let qr = SD.executeQuery("SELECT UniqueID from \(Table.Contacts.rawValue) WHERE ContactID = ?", withArgs: [contactID])
    if qr.error != nil { return [String]() }
    return qr.result.map { $0[self.uniqueIDKey()]?.asString() }.filter { $0 != nil }.map { $0! }
  }
  
  class func getMessagesForUniqueID(uniqueID: String) -> [Message] {
    let qr = SD.executeQuery("SELECT * from \(Table.Messages.rawValue) WHERE UniqueID = ?", withArgs: [uniqueID])
    if qr.error != nil { return [Message]() }
    return qr.result.map { self.messageFromRow($0) }.filter { $0 != nil}.map { $0! }
  }
  
  
  
  
  
  
  
  // MARK: Messages
  private class func toMeKey() -> String { return "Type" }
  private class func textKey() -> String { return "Text" }
  private class func attachmentIDKey() -> String { return "AttachmentID" }
  private class func timeKey() -> String { return "Time" }
  private class func uniqueIDKey() -> String { return "UniqueID" }
  
  class func getMessages(#limit: Int) -> [Message] {
    let qr = SD.executeQuery("SELECT * FROM messages LIMIT ?", withArgs: [limit])
    if qr.error != nil { return [Message]() }
    return qr.result.map { self.messageFromRow($0) }.filter { $0 != nil}.map { $0! }
  }
  
  class func messageFromRow(row: Row) -> Message? {
    let tm = row[toMeKey()]?.asString()
    let t = row[textKey()]?.asString()
    let time = row[timeKey()]?.asInt()
    let u = row[uniqueIDKey()]?.asString()
    let a = row[attachmentIDKey()]?.asInt()
    switch (tm,t,time, u) {
    case let (.Some(tm), .Some(t), .Some(time), .Some(u)):
      let toMe = tm != "to"
      let timeInterval = NSTimeInterval(time)
      let d = NSDate(timeIntervalSince1970: timeInterval)
      let aID = a == 0 ? nil : a
      return Message(toMe: toMe, text: t, time: d, uniqueID: u, attachmentID: aID)
    default:
      return nil
    }
  }
  
  // MARK: Attachments
  class func mimeType() -> String { return "mime_type" }
  class func sha1Filename() -> String { return "sha1_filename" }
  
  class func getAttachments() -> [Attachment] {
    let qr = SD.executeQuery("SELECT * FROM attachments")
    if qr.error != nil { return [Attachment]() }
    return qr.result.map { self.getAttachmentFromRow($0) }.filter { $0 != nil }.map { $0! }
  }
  
  class func getAttachmentFromRow(row: Row) -> Attachment? {
    let mt = row[mimeType()]?.asString()
    let s = row[sha1Filename()]?.asString()
    switch (mt,s) {
    case let (.Some(mt), .Some(s)):
      return Attachment(filename: s, type: mt)
    default:
      return nil
    }
  }
  
  // MARK: Contacts
  private class func firstNameKey() -> String { return "First" }
  private class func lastNameKey() -> String { return "Last" }
  private class func contactIDKey() -> String { return "ContactID" }
  class func getContacts() -> [Contact] {
    let qr = SD.executeQuery("SELECT * FROM contacts")
    if qr.error != nil { return [Contact]() }
    return qr.result.map({ self.contactFromRow($0) }).filter({ $0 != nil }).map({ $0! })
  }
  
  class func contactFromRow(row: SwiftData.SDRow) -> Contact? {
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
