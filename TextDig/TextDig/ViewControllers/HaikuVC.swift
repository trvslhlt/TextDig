//
//  HaikuVC.swift
//  TextDig
//
//  Created by trvslhlt on 2/8/15.
//  Copyright (c) 2015 travis holt. All rights reserved.
//

import UIKit

class HaikuVC: TDVC, Facing {
  
  @IBOutlet weak var textView: UITextView!
  
  class func faceMaterials() -> (name: String, tagline: String, icon: UIImage?) {
    return (name: "Haiku", tagline: "How can soy sauce do for you?", icon: nil)
  }
  
  required init() {
    super.init(nibName: "HaikuVC", bundle: nil)
  }

  required init(coder aDecoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    automaticallyAdjustsScrollViewInsets = false
    let haiku = haikuFromMessages(user.messages)
    textView.text = haiku
  }
  
  func haikuFromMessages(messages: [Message]) -> String {
    let haikuPattern = [5,7,5]
    let messageCount = messages.count
    let rmi = randomNumberBetweenMin(0, andMax: messageCount - haikuPattern.count)
    let haikuMessages = Array(messages[rmi..<(rmi + haikuPattern.count)])
    let haikuRawTexts = haikuMessages.map { $0.text }
    let zipped = Zip2(haikuPattern, haikuRawTexts).generate()
    let ts = Array(arrayLiteral: zipped)
    let cleanLines = map(Zip2(haikuRawTexts, haikuPattern)) { self.truncateText($0, toWordCount: $1)  }
    return cleanLines.reduce("") { $0 + "\n" + $1 }
  }
  
  func truncateText(text: String, toWordCount wordCount: Int) -> String {
    if wordCount < 1 { return "" }
    let splitWords = split(text) { $0 == " " || $0 == "\n" }
    let c = splitWords.count
    if c == 0 {
      return ""
    } else if c <= wordCount {
      return splitWords.reduce("") { $0 + " " + $1 }
    } else {
      return Array(splitWords[0..<wordCount]).reduce("") { $0 + " " + $1 }
    }
  }
  
}










