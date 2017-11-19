//
//  Work.swift
//  LendAHand
//
//  Created by Hoan Tran on 10/23/17.
//  Copyright © 2017 Hoan Tran. All rights reserved.
//

import Foundation

struct Work {
  
  var rate: Float
  var isPaid: Bool
  var start: Date
  var project: String?
  var stop: Date?
  var note: String?
  
  var dictionary: [String: Any] {
    return [
      "rate": rate,
      "isPaid": isPaid,
      "start": start,
      "project": project == nil ? NSNull() : project as Any,
      "stop": stop == nil ? NSNull() : stop as Any,
      "note": note == nil ? NSNull() : note as Any
    ]
  }
}

extension Work: DocumentSerializable {
  init?(dictionary: [String : Any]) {
    guard
      let rate = dictionary["rate"] as? Float,
      let isPaid = dictionary["isPaid"] as? Bool,
      let start = dictionary["start"] as? Date else { return nil }
    let project = dictionary["project"] == nil ? nil : dictionary["project"] as? String
    let stop = dictionary["stop"] == nil ? nil : dictionary["stop"] as? Date
    let note = dictionary["note"] == nil ? nil : dictionary["note"] as? String
    
    self.init(rate: rate, isPaid: isPaid, start: start, project: project, stop: stop, note: note)
  }
}

// UI Helper
extension Work {
  func duration() -> String? {
    if let stop = stop {
        let seconds = Int(stop.timeIntervalSince(start))
        let hrs = Int(seconds/(60 * 60))
        let mins = Int((seconds - (hrs * 60 * 60))/60)
        return "\(hrs)" + " hrs " + "\(mins)" + " mins"
    }
    return nil
  }

  func payable() -> String? {
    if let stop = stop {
      let seconds = Int(stop.timeIntervalSince(start))
      let hours:Float = Float(Float(seconds) / Float(3600))
      let payable: Float = rate * hours
      return payable.roundedTo(places: 2)
    }
    return nil
  }

//  static func getDateStr(unixDate: Int?) -> String {
//    if let date = unixDate {
//      let epochDate = Date(timeIntervalSince1970: TimeInterval(date))
//      let dayTimePeriodFormatter = DateFormatter()
//      dayTimePeriodFormatter.dateFormat = "MMM dd, YYYY  hh:mm a"
//
//      return dayTimePeriodFormatter.string(from: epochDate)
//    } else {
//      return ""
//    }
//  }
//
//  static func getDate(unixDate: Int?) -> Date {
//    if let date = unixDate {
//      return Date(timeIntervalSince1970: TimeInterval(date))
//    } else {
//      return Date()
//    }
//  }
//
//  static func getSpan(start: Int?, end: Int?) -> TimeInterval {
//    if let start = start, let end = end {
//      return TimeInterval(end - start)
//    } else {
//      return 0
//    }
//  }
}
