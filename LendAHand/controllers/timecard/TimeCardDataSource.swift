//
//  TimeCardDataSource.swift
//  LendAHand
//
//  Created by Hoan Tran on 11/13/17.
//  Copyright © 2017 Hoan Tran. All rights reserved.
//

import UIKit

//enum TimeCardSection: Int {
//  case rate = 0
//  case time
//  case misc
//  case note
//}
//
enum TimeCardArrangement: Int {
  case rate = 0, time, misc, note, count
  enum rateRow: Int {
    case rate = 0, count
  }
  enum timeRow: Int {
    case start = 0, stop, duration, count
  }
  enum miscRow: Int {
    case project = 0, isPaid, count
  }
  enum noteRow: Int {
    case row = 0, count
  }
}

extension TimeCardViewController: UITableViewDataSource {
  func refreshData(_ work: Work) {
    self.start.datex = work.start
    if let stop = work.stop {
      self.stop.datex = stop
    }
  }
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return TimeCardArrangement.count.rawValue
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    switch section {
    case TimeCardArrangement.rate.rawValue:
      return TimeCardArrangement.rateRow.count.rawValue
    case TimeCardArrangement.time.rawValue:
      return TimeCardArrangement.timeRow.count.rawValue
    case TimeCardArrangement.misc.rawValue:
      return TimeCardArrangement.miscRow.count.rawValue
    default:
      return TimeCardArrangement.noteRow.count.rawValue
    }
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    switch indexPath.section {
    case TimeCardArrangement.rate.rawValue:
      print("rate")
      return rate
    
    case TimeCardArrangement.time.rawValue:
      switch indexPath.row {
      case TimeCardArrangement.timeRow.start.rawValue:
        print("start")
        return start
      case TimeCardArrangement.timeRow.stop.rawValue:
        print("stop")
        return stop
      default:
        print("duration")
        return duration
      }
    
    case TimeCardArrangement.misc.rawValue:
      switch indexPath.row {
      case TimeCardArrangement.miscRow.project.rawValue:
        print("project")
        return project
      default:
        print("paid")
        return paid
      }

    default:
      print("note")
      return note
    }
  }
}
