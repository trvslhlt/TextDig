//
//  ChatCell.swift
//  TextDig
//
//  Created by trvslhlt on 1/18/15.
//  Copyright (c) 2015 travis holt. All rights reserved.
//

import UIKit

class ChatCell: UICollectionViewCell {
  
  @IBOutlet weak var textView: UITextView!
  
  class func cellReuseID() -> String { return "chatCell" }
  
  override func awakeFromNib() {
    super.awakeFromNib()
  }
  
}
