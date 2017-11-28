//
//  Current.swift
//  LendAHand
//
//  Created by Hoan Tran on 10/23/17.
//  Copyright © 2017 Hoan Tran. All rights reserved.
//

import Foundation

struct Current {
  
  var worker: String
  var start: Date
  var rate: Float
  
  var dictionary: [String: Any] {
    return [
      "worker": worker,
      "start": start,
      "rate": rate
    ]
  }
}

extension Current: DocumentSerializable {
  
  init?(dictionary: [String : Any]) {
    guard
      let worker = dictionary["worker"] as? String,
      let start = dictionary["start"] as? Date,
      let rate = dictionary["rate"] as? Float else { return nil }
    
    self.init(worker: worker, start: start, rate: rate)
  }
}
