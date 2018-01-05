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
  var worker: String
  var project: String?
  var stop: Date?
  var note: String?
  
  var dictionary: [String: Any] {
    return [
      "rate": rate,
      "isPaid": isPaid,
      "start": start,
      "worker": worker,
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
      let start = dictionary["start"] as? Date,
      let worker = dictionary["worker"] as? String else { return nil }
    let project = dictionary["project"] == nil ? nil : dictionary["project"] as? String
    let stop = dictionary["stop"] == nil ? nil : dictionary["stop"] as? Date
    let note = dictionary["note"] == nil ? nil : dictionary["note"] as? String
    
    self.init(rate: rate, isPaid: isPaid, start: start, worker: worker, project: project, stop: stop, note: note)
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
  
  func durationCompact() -> String? {
    if let stop = stop {
      let seconds = Int(stop.timeIntervalSince(start))
      let hrs = Int(seconds/(60 * 60))
      let mins = Int((seconds - (hrs * 60 * 60))/60)
      return String(format: "%d h %02d", hrs, mins)
    }
    return nil
  }

  func payable() -> String? {
    if let stop = stop {
      let seconds = Int(stop.timeIntervalSince(start))
//      let elapsed = ((Float(now.timeIntervalSince(start)))/60).rounded()
//      let earned = (elapsed/60) * rate
      let hours:Float = Float(Float(seconds) / Float(3600))
      let payable: Float = rate * hours
      return payable.roundedTo(places: 2)
    }
    return nil
  }
  
  func span() -> Int? {
    if let stop = stop {
      return Int(stop.timeIntervalSince(start))
    }
    return nil
  }
  
  func gross() -> Float? {
    if let seconds = self.span() {
      let hours = Float(Float(seconds) / Float(3600))
      return rate * hours
    }
    return nil
  }
}
