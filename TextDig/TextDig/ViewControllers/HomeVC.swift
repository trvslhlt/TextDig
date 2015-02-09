//
//  HomeVC.swift
//  TextDig
//
//  Created by trvslhlt on 1/18/15.
//  Copyright (c) 2015 travis holt. All rights reserved.
//

import UIKit

class HomeVC: TDVC {
  
  typealias Data = TDVC.Type
  let data: [Data] = [ChatVC.self, ContactsVC.self, HaikuVC.self]
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
  @IBOutlet weak var messageCountLabel: UILabel!
  
  required init() {
    self.cvDelegate = HomeCVDelegate(data: self.data)
    super.init(nibName: "HomeVC", bundle: nil)
  }

  required init(coder aDecoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    dao.getKiMessagesWithCompletion { messages in
      self.messageCountLabel.text = "\(self.user.messages.count)"
    }
  }
  
  // MARK: IBActions
  @IBAction func logoutTapped(sender: AnyObject) {
    logout()
  }
}
















