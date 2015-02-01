//
//  HomeCVDelegate.swift
//  TextDig
//
//  Created by trvslhlt on 2/1/15.
//  Copyright (c) 2015 travis holt. All rights reserved.
//

import UIKit

class HomeCVDelegate: NSObject, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
  
  typealias Data = UIViewController.Type
  let data: [Data]
  let cellReuseID = "homeCell"
  var selectedItem: ((Data) -> ())?
  
  init(data: [Data]) {
    self.data = data
    super.init()
  }
  
  // MARK: UICollectionViewDelegate
  func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
    return 1
  }
  
  func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return data.count
  }
  
  func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCellWithReuseIdentifier(cellReuseID, forIndexPath: indexPath) as UICollectionViewCell
    cell.layer.borderWidth = 1
    cell.backgroundColor = UIColor.darkGrayColor()
    return cell
  }
  
  func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
    self.selectedItem?(data[indexPath.row])
  }
  
}
