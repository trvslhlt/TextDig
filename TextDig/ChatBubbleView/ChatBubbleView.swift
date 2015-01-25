//
//  ChatBubbleView.swift
//  TextDig
//
//  Created by trvslhlt on 1/18/15.
//  Copyright (c) 2015 travis holt. All rights reserved.
//

import UIKit

@IBDesignable class ChatBubbleView: UIView {
  
  enum Side {
    case Left
    case Right
  }
  
  @IBInspectable var tailSide: Side = .Left { didSet { setupView() } }
  @IBInspectable var startColor: UIColor = UIColor.whiteColor() { didSet { setupView() } }
  @IBInspectable var endColor: UIColor = UIColor.blackColor() { didSet { setupView() } }
  @IBInspectable var startPoint: CGPoint = CGPoint(x: 100, y: 50) { didSet { setupView() } }
  @IBInspectable var endPoint: CGPoint = CGPoint(x: 100, y: 100) { didSet { setupView() } }
  var gradientLayer: CAGradientLayer { return layer as CAGradientLayer }
  override class func layerClass() -> AnyClass { return CAGradientLayer.self }
  lazy var maskLayer: CAShapeLayer = {
    let maskLayer = CAShapeLayer()
    maskLayer.fillColor = UIColor.greenColor().CGColor
    maskLayer.backgroundColor = UIColor.redColor().CGColor
    maskLayer.path = UIBezierPath(rect: CGRectInset(self.bounds, 20, 40)).CGPath
    return maskLayer
  }()
  
  required init(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    applyMask()
  }
  
  override func prepareForInterfaceBuilder() {
    super.prepareForInterfaceBuilder()
    setupView()
  }
  
  func applyMask() {
    self.layer.mask = maskLayer
  }
  
  func setupView() {
    let colors:Array = [startColor.CGColor, endColor.CGColor]
    gradientLayer.colors = colors
    gradientLayer.startPoint = percentagePointToUnit(startPoint)
    gradientLayer.endPoint = percentagePointToUnit(endPoint)
    self.setNeedsDisplay()
    self.layoutIfNeeded()
  }

  func percentagePointToUnit(percentagePoint: CGPoint) -> CGPoint {
    return CGPoint(x: percentagePoint.x / 100.0, y: percentagePoint.y / 100.0)
  }
  
  override func layoutSubviews() {
    maskLayer.path = bubblePath()
  }
  
  func bubblePath() -> CGPath {
    let rect = self.bounds
    let path = UIBezierPath()
    path.moveToPoint(CGPoint(x: rect.width / 2, y: 0))
    path.addLineToPoint(CGPoint(x: rect.width, y: 0))
    path.addLineToPoint(CGPoint(x: rect.width / 2, y: rect.height))
    path.addLineToPoint(CGPoint(x: 0, y: rect.height))
    path.closePath()
    return path.CGPath
  }
}













