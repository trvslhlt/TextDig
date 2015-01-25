//
//  TDDocumentManager.swift
//  TextDig
//
//  Created by trvslhlt on 1/24/15.
//  Copyright (c) 2015 travis holt. All rights reserved.
//

import UIKit

class TDDocumentManager: NSObject {
  
  private class func bundleDBName() -> String { return "clean" }
  private class func documentsDBName() -> String { return "SwiftData.sqlite" }
  
  class func copyDB() {
    let fileManager = NSFileManager.defaultManager()
    if let dbPathInBundle = pathInBundle(bundleDBName(), fileType: "db") {
      let dbPathInDocuments = filePathInDocuments(documentsDBName())
      if fileManager.fileExistsAtPath(dbPathInDocuments) {
        return
      }
      var error: NSError?
      fileManager.copyItemAtPath(dbPathInBundle, toPath: dbPathInDocuments, error: &error)
      if let e = error { println("\(e.localizedDescription)") }
    }
  }
  
  private class func pathInBundle(fileName: String, fileType: String) -> String? {
    return NSBundle.mainBundle().pathForResource(fileName, ofType: fileType)
  }
  
  private class func filePathInDocuments(fileName: String) -> String {
    let docsPath = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true) [0] as String
    return docsPath.stringByAppendingPathComponent(fileName)
  }
}
