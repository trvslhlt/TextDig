//
//  HomeVC.swift
//  TextDig
//
//  Created by trvslhlt on 1/18/15.
//  Copyright (c) 2015 travis holt. All rights reserved.
//

import UIKit

class HomeVC: TDVC, UICollectionViewDataSource, UICollectionViewDelegate {
  
  let cellReuseID = "cell"
  let detailVCClasses: [UIViewController.Type] = [ChatVC.self, ContactsVC.self]
  @IBOutlet weak var collectionView: UICollectionView! {
    didSet{
      collectionView.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: cellReuseID)
      let layout = collectionView.collectionViewLayout as UICollectionViewFlowLayout
      layout.sectionInset = UIEdgeInsetsZero
      layout.itemSize = CGSize(width: collectionView.bounds.size.width, height: 200)
      layout.minimumInteritemSpacing = 0
      layout.minimumLineSpacing = 0
    }
  }
  
  override init() {
    super.init(nibName: "HomeVC", bundle: nil)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
//    let messages = SQLiteGateway.getMessages(limit: 1000)
//    for message in messages {
//      println("\(message)")
//    }
    let attachments = SQLiteGateway.getAttachments()
    for a in attachments {
      println("\(a)")
    }
  }
  
  // MARK: UICollectionViewDelegate
  func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
    return 1
  }
  
  func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return detailVCClasses.count
  }
  
  func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCellWithReuseIdentifier(cellReuseID, forIndexPath: indexPath) as UICollectionViewCell
    cell.layer.borderWidth = 1
    return cell
  }
  
  func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
    let vcClass = detailVCClasses[indexPath.row]
    let x = vcClass()
    self.navigationController?.pushViewController(x, animated: true)
  }
  
}

















