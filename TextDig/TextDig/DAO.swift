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
  
  var contacts: [Contact] { didSet { save() } }
  var user: User { didSet { save() } }
  
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
    self.contacts = DAO.getContacts()
    self.user = User()
    super.init()
  }
  
  required init(coder aDecoder: NSCoder) {
    if let c = aDecoder.decodeObjectForKey(DAO.contactsKey) as? [Contact] {
      self.contacts = c
    } else {
      self.contacts = DAO.getContacts()
    }
    if let u = aDecoder.decodeObjectForKey(DAO.userKey) as? User {
      self.user = u
    } else {
      self.user = User()
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
    
    
//    if let data = NSUserDefaults.standardUserDefaults().objectForKey(contactsKey) as? NSData {
//      if let d = NSKeyedUnarchiver.unarchiveObjectWithData(data) as? DAO {
//        return d
//      }
//    }
    return DAO()
  }
  
//  + (id)readFromArchive {
//  NSString *archivePath = [[self class] filePath];
//  if (![[NSFileManager defaultManager] fileExistsAtPath:archivePath]) { return nil; }
//  return [NSKeyedUnarchiver unarchiveObjectWithFile:archivePath];
//  }
  
  func save() {
    let data = NSKeyedArchiver.archivedDataWithRootObject(self)
//    NSUserDefaults.standardUserDefaults().setObject(data, forKey: DAO.userKey)
//    NSUserDefaults.standardUserDefaults().synchronize()
    NSKeyedArchiver.archiveRootObject(self, toFile: DAO.filepath)
  }
  
//  - (void)persist {
//  UIApplication *application = [UIApplication sharedApplication];
//  __block UIBackgroundTaskIdentifier bgTask;
//  bgTask = [application beginBackgroundTaskWithExpirationHandler:^{
//  [application endBackgroundTask:bgTask];
//  bgTask = UIBackgroundTaskInvalid;
//  }];
//  
//  dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//  id copy = self.copy;
//  [NSKeyedArchiver archiveRootObject:copy toFile:[[copy class] filePath]];
//  
//  [application endBackgroundTask:bgTask];
//  bgTask = UIBackgroundTaskInvalid;
//  });
//  }
  
  func clear() {
    if NSFileManager.defaultManager().fileExistsAtPath(DAO.filepath) {
      NSFileManager.defaultManager().removeItemAtPath(DAO.filepath, error: nil)
    }
//    NSUserDefaults.standardUserDefaults().removeObjectForKey(self.animalsKey)
//    NSUserDefaults.standardUserDefaults().synchronize()
    
    
  }
  
//  + (id)readFromArchive {
//  NSString *archivePath = [[self class] filePath];
//  if (![[NSFileManager defaultManager] fileExistsAtPath:archivePath]) { return nil; }
//  return [NSKeyedUnarchiver unarchiveObjectWithFile:archivePath];
//  }
//
//  + (void)resetArchive {
//  [[NSFileManager defaultManager] removeItemAtPath:[[self class] filePath] error:nil];
//  }
 // MARK: Models
  class func getContacts() -> [Contact] { return SQLiteGateway.getContacts() }

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
