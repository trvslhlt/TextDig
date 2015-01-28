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
  
  init(collectionView: UICollectionView) {
    self.collectionView = collectionView
    super.init()
    self.collectionView.delegate = self
    self.collectionView.dataSource = self
    self.collectionView.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
  }
  
  func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
    return 1
  }
  
  func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 20
  }
  
  func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as UICollectionViewCell
    return cell
  }
  
  // MARK: Layout
  func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
    let screenWidth = UIScreen.mainScreen().bounds.size.width
    return CGSize(width: screenWidth, height: 100)
  }
  
}
