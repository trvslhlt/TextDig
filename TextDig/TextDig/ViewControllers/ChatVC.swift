//
//  ChatVC.swift
//  TextDig
//
//  Created by trvslhlt on 1/18/15.
//  Copyright (c) 2015 travis holt. All rights reserved.
//

import UIKit

class ChatVC: TDVC {
  
  let maxNumberOfMessages = 50
  let minNumberOfMessages = 5
  
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
    collectionViewDelegate?.messages = newMessages
    collectionView.reloadData()
    collectionView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
  }
  
  func getRandomNumberBetweenMin(min: Int, andMax max: Int) -> Int{
    let minimum = min >= 0 ? min : 0
    let maximum = max > min ? max : minimum + 1
    let diff = maximum - minimum
    return minimum + (random() % diff)
  }
  
  func getRandomStartingIndexWithLimit(limit: Int) -> Int {
    return random() % limit
  }
  
  func getRandomArrayFromMessages(messages: [Message]) -> [Message] {
    let limit = messages.count - 1
    let startingIndex = getRandomStartingIndexWithLimit(limit)
    let ei = startingIndex + getRandomNumberBetweenMin(self.minNumberOfMessages, andMax: self.maxNumberOfMessages)
    let endingIndex = ei >= limit ? limit : ei
    return Array(messages[startingIndex...endingIndex])
  }
  
}





