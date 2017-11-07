//
//  Worker.swift
//  LendAHand
//
//  Created by Hoan Tran on 10/20/17.
//  Copyright © 2017 Hoan Tran. All rights reserved.
//

import Foundation

struct Worker {
  
  var contact: String
  var rate: Float
  
  var dictionary: [String: Any] {
    return [
      "contact": contact,
      "rate": rate
    ]
  }
}

extension Worker: DocumentSerializable {
  
  init?(dictionary: [String : Any]) {
    guard let contact = dictionary["contact"] as? String,
      let rate = dictionary["rate"] as? Float else { return nil }
    
    self.init(contact: contact, rate: rate)
  }
}

extension Worker: Equatable {
  static func ==(lhs: Worker, rhs: Worker) -> Bool {
    return lhs.contact == rhs.contact
  }
}


