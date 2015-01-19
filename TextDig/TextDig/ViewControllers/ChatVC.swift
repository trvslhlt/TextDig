//
//  ChatVC.swift
//  TextDig
//
//  Created by trvslhlt on 1/18/15.
//  Copyright (c) 2015 travis holt. All rights reserved.
//

import UIKit

class ChatVC: TBVC {
  
  var collectionViewDelegate: ChatCollectionViewDelegate?
  @IBOutlet weak var collectionView: UICollectionView! {
    didSet {
      self.collectionViewDelegate = ChatCollectionViewDelegate(collectionView: self.collectionView)
    }
  }
  
  override init() {
    super.init(nibName: "ChatVC", bundle: nil)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.collectionView.reloadData()
  }
  
  // MARK: Layout
  override func deviceOrientationChanged() {
    self.view.setNeedsLayout()
    self.collectionView.collectionViewLayout.invalidateLayout()
  }
  
}
