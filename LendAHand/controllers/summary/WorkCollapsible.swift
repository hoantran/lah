//
//  SummaryCollapsible.swift
//  LendAHand
//
//  Created by Hoan Tran on 12/1/17.
//  Copyright © 2017 Hoan Tran. All rights reserved.
//

import Foundation

struct WorkCollapsible {
  var isOpen = false
  var works: [Work]
  var amount: Float // dollars
  var duration: Int // seconds
  let workerID: String
  
  init(_ work: Work) {
    self.isOpen = false
    self.works = Array<Work>()
    self.amount = 0.00
    self.duration = 0
    self.workerID = work.worker
    self.add(work)
  }
  
  private func getDuration(_ work: Work) -> Int {
    if let duration = work.span() {
      return duration
    } else {
      return 0
    }
  }
  
  private func getAmount(_ work: Work) -> Float {
    if let amount = work.gross() {
      return amount
    } else {
      return 0.00
    }
  }
  
  mutating func add(_ work: Work) {
    self.amount += getAmount(work)
    self.duration += getDuration(work)

    works.append(work)
  }
}
