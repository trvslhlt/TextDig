//
//  Attachment.swift
//  TextDig
//
//  Created by trvslhlt on 1/25/15.
//  Copyright (c) 2015 travis holt. All rights reserved.
//

import UIKit

class Attachment: Model {
  
  let filename: String
  let type: String
  var image: UIImage?
  // TODO: Add audio/video
  
  init(filename: String, type: String) {
    self.filename = filename
    self.type = type
    super.init()
  }
}
