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
  var work: String
  
  var dictionary: [String: Any] {
    return [
      "worker": worker,
      "work": work
    ]
  }
}

extension Current: DocumentSerializable {
  
  init?(dictionary: [String : Any]) {
    guard let worker = dictionary["worker"] as? String,
      let work = dictionary["work"] as? String else { return nil }
    
    self.init(worker: worker, work: work)
  }
}
