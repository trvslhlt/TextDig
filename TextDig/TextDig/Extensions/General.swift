//
//  General.swift
//  TextDig
//
//  Created by trvslhlt on 2/8/15.
//  Copyright (c) 2015 travis holt. All rights reserved.
//

import Foundation

func randomNumberBetweenMin(min: Int, andMax max: Int) -> Int{
  let minimum = min >= 0 ? min : 0
  let maximum = max > min ? max : minimum + 1
  let diff = maximum - minimum
  let r = Int(arc4random_uniform(UInt32(diff)))
  return minimum + r
}