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

class DAO: Model, NSCoding {
  
  var contacts: [Contact] = [Contact]() { didSet { save() } }
  var user: User = User() { didSet { save() } }
  let modelQueue = NSOperationQueue()
  
  private class var selfKey: String { get { return "dao" } }
  private class var contactsKey: String { get { return "contacts" } }
  private class var userKey: String { get { return "user" } }
  private class var filepath: String {
    get {
      let paths = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)
      let documentsDirectoryPath = paths[0] as String
      return documentsDirectoryPath.stringByAppendingPathComponent(selfKey)
    }
  }
  
  class var sharedInstance: DAO {
    struct Singleton {
      static let instance = DAO.loadSaved()
    }
    return Singleton.instance
  }
  
  override init() {
    super.init()
    self.contacts = self.getContacts()
  }
  
  required init(coder aDecoder: NSCoder) {
    super.init()
    if let c = aDecoder.decodeObjectForKey(DAO.contactsKey) as? [Contact] {
      self.contacts = c
    } else {
      self.contacts = self.getContacts()
    }
    if let u = aDecoder.decodeObjectForKey(DAO.userKey) as? User {
      self.user = u
    }
  }
  
  func encodeWithCoder(aCoder: NSCoder) {
    aCoder.encodeObject(self.contacts, forKey: DAO.contactsKey)
    aCoder.encodeObject(self.user, forKey: DAO.userKey)
  }
  
  class func loadSaved() -> DAO {
    let filepath = DAO.filepath
    if NSFileManager.defaultManager().fileExistsAtPath(filepath) {
      if let dao = NSKeyedUnarchiver.unarchiveObjectWithFile(filepath) as? DAO {
        return dao
      }
    }
    return DAO()
  }
  
  func save() {
    let data = NSKeyedArchiver.archivedDataWithRootObject(self)
    NSKeyedArchiver.archiveRootObject(self, toFile: DAO.filepath)
  }
  
  func clear() {
    if NSFileManager.defaultManager().fileExistsAtPath(DAO.filepath) {
      NSFileManager.defaultManager().removeItemAtPath(DAO.filepath, error: nil)
    }
  }
  
  func getContacts() -> [Contact] { return SQLiteGateway.getContacts() }
  func getKiMessagesWithCompletion(completion: ([Message] -> ())) {
    modelQueue.addOperationWithBlock(){
      if let contactID = SQLiteGateway.getContactIDForName("ki") {
        let uniqueIDs = SQLiteGateway.getUniqueIDsForContactID(contactID)
        let messages = uniqueIDs.map { SQLiteGateway.getMessagesForUniqueID($0) }.reduce([Message]()) { $0 + $1 }
        NSOperationQueue.mainQueue().addOperationWithBlock(){
          completion(messages)
        }
      }
    }
  }
  
  func kiMessagesUpdated() {
    
  }
}





//
//- (void)makePersitable {
//  [[NSNotificationCenter defaultCenter] addObserver:self
//    selector:@selector(persist)
//  name:UIApplicationWillResignActiveNotification
//  object:nil];
//  }
//
//  - (void)cancelPersistance {
//    [[NSNotificationCenter defaultCenter] removeObserver:self];
//    }

//
//        + (id)readFromArchive {
//          NSString *archivePath = [[self class] filePath];
//          if (![[NSFileManager defaultManager] fileExistsAtPath:archivePath]) { return nil; }
//          return [NSKeyedUnarchiver unarchiveObjectWithFile:archivePath];
//          }
//
//          + (void)resetArchive {
//            [[NSFileManager defaultManager] removeItemAtPath:[[self class] filePath] error:nil];
//          }
