//
//  ChatVC.swift
//  TextDig
//
//  Created by trvslhlt on 1/18/15.
//  Copyright (c) 2015 travis holt. All rights reserved.
//

import UIKit

class ChatVC: TDVC {
  
  let maxNumberOfMessages = 30
  let minNumberOfMessages = 1
  
  let collectionViewDelegate = ChatCollectionViewDelegate()

  @IBOutlet weak var collectionView: UICollectionView! {
    didSet {
      self.collectionView.delegate = self.collectionViewDelegate
      self.collectionView.dataSource = self.collectionViewDelegate
      self.collectionView.registerNib(UINib(nibName: "ChatCell", bundle: nil), forCellWithReuseIdentifier: ChatCell.cellReuseID())
    }
  }
  
  required init() {
    super.init(nibName: "ChatVC", bundle: nil)
  }

  required init(coder aDecoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    refreshMessages()
    addRefreshButton()
  }
  
  // MARK: Layout
  override func deviceOrientationChanged() {
    self.view.setNeedsLayout()
    self.collectionView.collectionViewLayout.invalidateLayout()
  }
  
  func addRefreshButton() {
    let btn = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Redo, target: self, action: Selector("refreshTapped:"))
    self.navigationItem.rightBarButtonItem = btn
  }
  
  // MARK: IBActions
  func refreshTapped(sender: UIBarButtonItem) {
    refreshMessages()
  }
  
  // MARK: Utility
  func refreshMessages() {
    let newMessages = getRandomArrayFromMessages(user.messages)
    collectionViewDelegate.messages = newMessages
    collectionView.reloadData()
    collectionView.scrollRectToVisible(CGRect(x: 0, y: 0, width: 1, height: 1), animated: true)
  }
  
//  func getRandomNumberBetweenMin(min: Int, andMax max: Int) -> Int{
//    let minimum = min >= 0 ? min : 0
//    let maximum = max > min ? max : minimum + 1
//    let diff = maximum - minimum
//    let r = Int(arc4random_uniform(UInt32(diff)))
//    return minimum + r
//  }
  
  func getRandomStartingIndexWithLimit(limit: Int) -> Int {
    return random() % limit
  }
  
  func getRandomArrayFromMessages(messages: [Message]) -> [Message] {
    let limit = messages.count - 1
    let startingIndex = getRandomStartingIndexWithLimit(limit)
    let ei = startingIndex + randomNumberBetweenMin(self.minNumberOfMessages, andMax: self.maxNumberOfMessages)
    let endingIndex = ei >= limit ? limit : ei
    return Array(messages[startingIndex...endingIndex])
  }
  
}





