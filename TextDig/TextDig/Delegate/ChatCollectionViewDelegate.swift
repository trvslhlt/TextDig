//
//  ChatCollectionViewDelegate.swift
//  TextDig
//
//  Created by trvslhlt on 1/18/15.
//  Copyright (c) 2015 travis holt. All rights reserved.
//

import UIKit

class ChatCollectionViewDelegate: NSObject, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UICollectionViewDelegate {
  
  var messages = [Message]()
  
  func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
    return 1
  }
  
  func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return messages.count
  }
  
  func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCellWithReuseIdentifier(ChatCell.cellReuseID(), forIndexPath: indexPath) as ChatCell
    
    let message = messages[indexPath.row]
    cell.textView.text = message.text
    cell.textView.textAlignment = message.toMe ? NSTextAlignment.Right : NSTextAlignment.Left
    
    return cell
  }
  
  // MARK: Layout
  func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
    let text = messages[indexPath.row].text
    let t = text.isEmpty ? " " : text
    return cellSizeWithText(t, font: ChatCell.cellFont(), containerWidth: collectionView.bounds.size.width)
  }
  
  func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
    return 0
  }
  
  func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
    return 0
  }
  
  func cellSizeWithText(text: String, font: UIFont, containerWidth: CGFloat) -> CGSize {
    let tv = UITextView()
    tv.text = text
    tv.font = font
    let tvMaxWidth = ChatCell.maxTextViewWidth(containerWidth)
    let tvIdealSize = tv.sizeThatFits(CGSize(width: tvMaxWidth, height: CGFloat.max))
    let tvSize =  CGSize(width: tvMaxWidth, height: tvIdealSize.height)
    return CGSize(width: containerWidth, height: tvSize.height)
  }

}
