//
//  HomeVC.swift
//  TextDig
//
//  Created by trvslhlt on 1/18/15.
//  Copyright (c) 2015 travis holt. All rights reserved.
//

import UIKit

class HomeVC: TDVC {
  
  typealias Data = UIViewController.Type
  let data: [Data] = [ChatVC.self, ContactsVC.self]
  let cvDelegate: HomeCVDelegate
  @IBOutlet weak var collectionView: UICollectionView! {
    didSet{
      collectionView.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: "homeCell")
      let layout = collectionView.collectionViewLayout as UICollectionViewFlowLayout
      layout.sectionInset = UIEdgeInsetsZero
      layout.itemSize = CGSize(width: UIScreen.mainScreen().bounds.width, height: 200)
      layout.minimumInteritemSpacing = 0
      layout.minimumLineSpacing = 0
      collectionView.delegate = self.cvDelegate
      collectionView.dataSource = self.cvDelegate
      self.cvDelegate.selectedItem = { item in
        let x = item()
        self.navigationController?.pushViewController(x, animated: true)
      }
    }
  }
  
  override init() {
    self.cvDelegate = HomeCVDelegate(data: self.data)
    super.init(nibName: "HomeVC", bundle: nil)
  }
  
  // MARK: Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
//    if let contactID = SQLiteGateway.getContactIDForName("ki") {
//      let uniqueIDs = SQLiteGateway.getUniqueIDsForContactID(contactID)
//      let messages = uniqueIDs.map { SQLiteGateway.getMessagesForUniqueID($0) }.reduce([Message]()) { $0 + $1 }
//      let msgWithAttachments = messages.filter { $0.attachmentID != nil }
//      println("\(msgWithAttachments)")
//    }
  }
  
  // MARK: IBActions
  @IBAction func logoutTapped(sender: AnyObject) {
    logout()
  }
}
















