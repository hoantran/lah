//
//  CellObserver.swift
//  LendAHand
//
//  Created by Hoan Tran on 11/14/17.
//  Copyright © 2017 Hoan Tran. All rights reserved.
//

import Foundation

protocol CellObserver {
  func observeChanges()
  func ignoreChanges()
}

extension CellObserver {
  func observeChanges(){}
  func ignoreChanges(){}
}
