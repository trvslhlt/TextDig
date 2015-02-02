//
//  StandardModalTransition.swift
//  TextDig
//
//  Created by trvslhlt on 2/1/15.
//  Copyright (c) 2015 travis holt. All rights reserved.
//

import UIKit

class StandardModalTransition: NSObject, UIViewControllerAnimatedTransitioning {
  
  var presenting = false
  
  func transitionDuration(transitionContext: UIViewControllerContextTransitioning) -> NSTimeInterval {
    return 0.5
  }
  
  func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
    let fromVC = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)
    let toVC = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)
    
    if presenting {
      // TODO: Implement
    } else {
      // TODO: Implement
    }
  }
  
}

