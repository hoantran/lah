//
//  TimeCardDataSource.swift
//  LendAHand
//
//  Created by Hoan Tran on 11/13/17.
//  Copyright © 2017 Hoan Tran. All rights reserved.
//

import UIKit


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
      let cell = tableView.dequeueReusableCell(withIdentifier: TimeCardRateCell.cellID, for: indexPath) as! TimeCardRateCell
      if let work = self.work {
        cell.rate.text = work.rate.roundedTo(places: 2)
      }
      return cell
    
    case TimeCardArrangement.time.rawValue:
      switch indexPath.row {
      case TimeCardArrangement.timeRow.start.rawValue:
        print("start")
        let cell = tableView.dequeueReusableCell(withIdentifier: TimeCardDatePickerCell.cellID, for: indexPath) as! TimeCardDatePickerCell
        cell.title = "START"
        cell.maxDate = self.startMax
        if let work = self.work {
          cell.date = work.start
        }
        cell.updateHandler = { [unowned self] date in
          self.work?.start = date
          self.stopMin = date
          if let stop = self.work?.stop {
            if stop < self.stopMin {
              self.work?.stop = self.stopMin
            }
          }
          self.reloadDuration()
        }
        return cell

      case TimeCardArrangement.timeRow.stop.rawValue:
        print("stop")
        let cell = tableView.dequeueReusableCell(withIdentifier: TimeCardDatePickerCell.cellID, for: indexPath) as! TimeCardDatePickerCell
        cell.title = "STOP"
        cell.minDate = self.stopMin
        if let work = self.work {
          if let stop = work.stop {
            cell.date = stop
          } else {
            print("Err: stop time must be present here.")
            cell.date = Date()
          }
        }
        cell.updateHandler = { [unowned self] date in
          self.work?.stop = date
          self.startMax = date
          if let start = self.work?.start {
            if start > self.startMax {
              self.work?.start = self.startMax
            }
          }
          self.reloadDuration()
        }
        return cell
      default:
        print("duration")
        let cell = tableView.dequeueReusableCell(withIdentifier: TimeCardTitleValueCell.cellID, for: indexPath) as! TimeCardTitleValueCell
        cell.title = "DURATION"
        if let duration = work?.duration() {
          cell.value = duration
        } else {
          cell.value = "0h 0m"
        }
        return cell
      }
    
    case TimeCardArrangement.misc.rawValue:
      switch indexPath.row {
      case TimeCardArrangement.miscRow.project.rawValue:
        print("project")
        let cell = tableView.dequeueReusableCell(withIdentifier: TimeCardRateCell.cellID, for: indexPath) as! TimeCardRateCell
        cell.textLabel?.text = "PROJECT"
        return cell
      default:
        print("paid")
        let cell = tableView.dequeueReusableCell(withIdentifier: TimeCardRateCell.cellID, for: indexPath) as! TimeCardRateCell
        cell.textLabel?.text = "PAID"
        return cell

      }

    default:
      print("note")
      let cell = tableView.dequeueReusableCell(withIdentifier: TimeCardRateCell.cellID, for: indexPath) as! TimeCardRateCell
      cell.textLabel?.text = "NOTE"
      return cell

    }
  }
}

extension TimeCardViewController {
  func newStart(_ date: Date) {
    self.work?.start = date
  }
}

