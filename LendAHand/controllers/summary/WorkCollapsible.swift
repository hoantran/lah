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
  var workIDs: [String]
  var amount: Float // dollars
  var duration: Int // seconds
  let workerID: String
  
  init(workID: String, work: Work) {
    self.isOpen = false
    self.works = Array<Work>()
    self.workIDs = Array<String>()
    self.amount = 0.00
    self.duration = 0
    self.workerID = work.worker
    self.add(workID: workID, work: work)
  }
  
  func earliestDate()->Date {
    var result = Date.distantFuture
    result = works.reduce(result, { earliest, next in
      if next.start.compare(earliest) == .orderedAscending {
        return next.start
      } else {
        return earliest
      }
    })
    return result
  }
  
  func latestDate()->Date {
    var result = Date.distantPast
    result = works.reduce(result, { latest, next in
      if let nextStop = next.stop {
        if latest.compare(nextStop) == .orderedAscending {
          return nextStop
        }
      }
      return latest
    })
    return result
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
  
  mutating func add(workID: String, work: Work) {
    self.amount += getAmount(work)
    self.duration += getDuration(work)

    works.append(work)
    workIDs.append(workID)
  }
}
