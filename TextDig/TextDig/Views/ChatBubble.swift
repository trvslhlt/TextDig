//
//  ChatBubble.swift
//  TextDig
//
//  Created by trvslhlt on 2/3/15.
//  Copyright (c) 2015 travis holt. All rights reserved.
//

import UIKit

class ChatBubble: UIView {
  
  let maskLayer = CAShapeLayer()
  let radius: CGFloat = 10
  
  override func awakeAfterUsingCoder(aDecoder: NSCoder) -> AnyObject? {
    super.awakeAfterUsingCoder(aDecoder)
    setup()
    return self
  }
  
  func setup() {
    layer.mask = maskLayer
    contentMode = UIViewContentMode.Redraw
  }
  
  override func drawRect(rect: CGRect) {
    let path = UIBezierPath()
    let viewWidth = self.bounds.width
    let viewHeight = self.bounds.height
    
    let tl = CGPoint(x: radius, y: 0)
    let tr = CGPoint(x: viewWidth - radius, y: 0)
    let rt = CGPoint(x: viewWidth, y: radius)
    let rb = CGPoint(x: viewWidth, y: viewHeight - radius)
    let br = CGPoint(x: viewWidth - radius, y: viewHeight)
    let bl = CGPoint(x: radius, y: viewHeight)
    let lb = CGPoint(x: 0, y: viewHeight - radius)
    let lt = CGPoint(x: 0, y: radius)
    path.moveToPoint(tl)
    path.addLineToPoint(tr)
    arcFromPoint(tr, toPoint: rt, aroundCenter: CGPoint(x: tr.x, y: rt.y), onPath: path)
    path.addLineToPoint(rb)
    arcFromPoint(rb, toPoint: br, aroundCenter: CGPoint(x: br.x, y: rb.y), onPath: path)
    path.addLineToPoint(bl)
    arcFromPoint(bl, toPoint: lb, aroundCenter: CGPoint(x: bl.x, y: lb.y), onPath: path)
    path.addLineToPoint(lt)
    arcFromPoint(lt, toPoint: tl, aroundCenter: CGPoint(x: tl.x, y: lt.y), onPath: path)
    path.closePath()
    maskLayer.path = path.CGPath
    maskLayer.frame = bounds
  }
  
  func arcFromPoint(startPoint: CGPoint , toPoint endPoint: CGPoint, aroundCenter centerPoint: CGPoint, onPath path: UIBezierPath) {
    let radius = distanceFromPoint(startPoint, toPoint: centerPoint)
    let startAngle = angleFromPoint(startPoint, andCenter: centerPoint)
    let endAngle = angleFromPoint(endPoint, andCenter: centerPoint)
    path.addArcWithCenter(centerPoint, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: true)
  }
  
  func distanceFromPoint(fromPoint: CGPoint, toPoint: CGPoint) -> CGFloat {
    return sqrt(pow((fromPoint.x - toPoint.x),2) + pow((fromPoint.y - toPoint.y),2))
  }
  
  func angleFromPoint(point: CGPoint, andCenter center: CGPoint) -> CGFloat {
    let x = point.x - center.x
    let y = (point.y - center.y)
    return atan2(y, x)
  }
  
}











