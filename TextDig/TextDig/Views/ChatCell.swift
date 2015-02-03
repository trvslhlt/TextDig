//
//  ChatCell.swift
//  TextDig
//
//  Created by trvslhlt on 1/18/15.
//  Copyright (c) 2015 travis holt. All rights reserved.
//

import UIKit

class ChatCell: UICollectionViewCell {
  
  @IBOutlet weak var textView: UITextView! {
    didSet {
      textView.textContainer.lineFragmentPadding = 0
      textView.textContainerInset = UIEdgeInsetsZero
      textView.font = ChatCell.cellFont()
    }
  }
  
  class func cellReuseID() -> String { return "chatCell" }
  class func cellFont() -> UIFont { return UIFont.systemFontOfSize(14) }
  class func bubbleInsetFromCell() -> CGFloat { return CGFloat.tdStandardSpacing() }
  class func textInsetFromBubble() -> CGFloat { return 0 }
  class func maxTextViewWidth(containerWidth: CGFloat) -> CGFloat {
    return containerWidth - (2 * bubbleInsetFromCell()) - (2 * textInsetFromBubble())
  }
  
  override func awakeFromNib() {
    super.awakeFromNib()
  }
}
