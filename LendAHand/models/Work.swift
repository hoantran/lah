//
//  Work.swift
//  LendAHand
//
//  Created by Hoan Tran on 10/23/17.
//  Copyright © 2017 Hoan Tran. All rights reserved.
//

import Foundation

struct Work {
  
  var project: String
  var rate: Float
  var isPaid: Bool
  var start: Date
  var stop: Date?
  var note: String?
  
  var dictionary: [String: Any] {
    return [
      "project": project,
      "rate": rate,
      "isPaid": isPaid,
      "start": start,
      "stop": stop == nil ? NSNull() : stop as Any,
      "note": note == nil ? NSNull() : note as Any
    ]
  }
}

extension Work: DocumentSerializable {
  init?(dictionary: [String : Any]) {
    guard let project = dictionary["project"] as? String,
      let rate = dictionary["rate"] as? Float,
      let isPaid = dictionary["isPaid"] as? Bool,
      let start = dictionary["start"] as? Date else { return nil }
    let stop = dictionary["stop"] == nil ? nil : dictionary["stop"] as? Date
    let note = dictionary["note"] == nil ? nil : dictionary["note"] as? String
    
    self.init(project: project, rate: rate, isPaid: isPaid, start: start, stop: stop, note: note)
  }
}
