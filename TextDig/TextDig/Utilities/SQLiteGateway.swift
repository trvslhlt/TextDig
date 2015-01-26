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
  
  // MARK: Messages
  private class func toMeKey() -> String { return "Type" }
  private class func textKey() -> String { return "Text" }
  private class func attachmentIDKey() -> String { return "AttachmentID" }
  private class func timeKey() -> String { return "Time" }
  private class func uniqueIDKey() -> String { return "UniqueID" }
  
  class func getMessages(#limit: Int) -> [Message] {
    let qr = SD.executeQuery("SELECT * FROM messages LIMIT ?", withArgs: [limit])
    if qr.1 != nil { return [Message]() }
    return qr.0.map { self.messageFromRow($0) }.filter { $0 != nil}.map { $0! }
  }
  
  class func messageFromRow(row: Row) -> Message? {
    let tm = row[toMeKey()]?.asString()
    let t = row[textKey()]?.asString()
    let time = row[timeKey()]?.asInt()
    let u = row[uniqueIDKey()]?.asString()
    let a = row[attachmentIDKey()]?.asString()
    switch (tm,t,time, u) {
    case let (.Some(tm), .Some(t), .Some(time), .Some(u)):
      let toMe = tm != "to"
      let timeInterval = NSTimeInterval(time)
      let d = NSDate(timeIntervalSince1970: timeInterval)
      return Message(toMe: toMe, text: t, time: d, uniqueID: u, attachmentID: a)
    default:
      return nil
    }
  }
  
  // MARK: Attachments
  class func mimeType() -> String { return "mime_type" }
  class func sha1Filename() -> String { return "sha1_filename" }
  
  class func getAttachments() -> [Attachment] {
    let qr = SD.executeQuery("SELECT * FROM attachments")
    if qr.1 != nil { return [Attachment]() }
    return qr.0.map { self.getAttachmentFromRow($0) }.filter { $0 != nil }.map { $0! }
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
    if qr.1 != nil { return [Contact]() }
    return qr.0.map({ self.contactFromRow($0) }).filter({ $0 != nil }).map({ $0! })
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
