//
//  Model.swift
//  TextDig
//
//  Created by trvslhlt on 1/25/15.
//  Copyright (c) 2015 travis holt. All rights reserved.
//

import UIKit

class Model: NSObject, Printable {
  
  func description() -> String {
    let printableProperties = propertyNames().map { (propertyName: String) -> String in
      if let value: AnyObject = self.valueForKey(propertyName) { return "\(propertyName): \(value)" }
      return propertyName
    }
    return join("\n", printableProperties) + "\n"
  }
  
  func propertyNames() -> [String] {
    var count : UInt32 = 0
    let classToInspect = self.dynamicType
    let properties : UnsafeMutablePointer <objc_property_t> = class_copyPropertyList(classToInspect, &count)
    var propertyNames : [String] = []
    let intCount = Int(count)
    for var i = 0; i < intCount; i++ {
      let property : objc_property_t = properties[i]
      let propertyName = NSString(UTF8String: property_getName(property))!
      propertyNames.append(propertyName)
    }
    free(properties)
    return propertyNames
  }
}

