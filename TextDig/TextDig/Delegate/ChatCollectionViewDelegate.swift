//
//  ChatCollectionViewDelegate.swift
//  TextDig
//
//  Created by trvslhlt on 1/18/15.
//  Copyright (c) 2015 travis holt. All rights reserved.
//

import UIKit

class ChatCollectionViewDelegate: NSObject, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UICollectionViewDelegate {
  
  let collectionView: UICollectionView
  var messages = [Message]()
  
  init(collectionView: UICollectionView) {
    self.collectionView = collectionView
    super.init()
    self.collectionView.delegate = self
    self.collectionView.dataSource = self
    self.collectionView.registerNib(UINib(nibName: "ChatCell", bundle: nil), forCellWithReuseIdentifier: ChatCell.cellReuseID())
  }
  
  func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
    return 1
  }
  
  func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return messages.count
  }
  
  func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCellWithReuseIdentifier(ChatCell.cellReuseID(), forIndexPath: indexPath) as ChatCell
    
    cell.textView.text = messages[indexPath.row].text
    
    return cell
  }
  
  // MARK: Layout
  func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
    let screenWidth = UIScreen.mainScreen().bounds.size.width
    return CGSize(width: screenWidth, height: 100)
  }
  
}
