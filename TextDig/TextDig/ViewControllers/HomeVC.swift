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
      layout.itemSize = CGSize(width: collectionView.bounds.size.width, height: 200)
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
  }
  
  // MARK: IBActions
  @IBAction func logoutTapped(sender: AnyObject) {
    logout()
  }
}






////    let messages = SQLiteGateway.getMessages(limit: )
////    for message in messages {
////      println("\(message)")
////    }
//    let attachments = SQLiteGateway.getAttachments()
////    for a in attachments {
////      pri1000ntln("\(a)")
////    }
//    println("done")
















