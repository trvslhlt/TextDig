//
//  Global.swift
//  TextDig
//
//  Created by trvslhlt on 2/2/15.
//  Copyright (c) 2015 travis holt. All rights reserved.
//

import UIKit


extension CGFloat {
  static func tdStandardSpacing() -> CGFloat { return 8.0 }
}

class Box<T> {
  let unbox: T
  init(_ value: T) { self.unbox = value }
}

enum Result<T> {
  case Success(Box<T>)
  case Failure(NSError)
}

func map<T, U>(f: T -> U, result: Result<T>) -> Result<U> {
  switch result {
  case let .Success(box):
    return Result.Success(Box(f(box.unbox)))
  case let .Failure(error):
    return Result.Failure(error)
  }
}

func ??<T>(result: Result<T>, handleError: NSError -> T) -> T{
  switch result {
  case let Result.Success(box):
    return box.unbox
  case let Result.Failure(error):
    return handleError(error)
  }
}