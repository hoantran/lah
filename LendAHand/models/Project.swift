//
//  Project.swift
//  LendAHand
//
//  Created by Hoan Tran on 10/20/17.
//  Copyright © 2017 Hoan Tran. All rights reserved.
//

import Foundation

struct Project {
  
  var contact: String?
  var name: String
  var completed: Bool
  
  var dictionary: [String: Any] {
    return [
      "contact": contact == nil ? NSNull() : contact as Any,
      "name": name,
      "completed": completed,
    ]
  }
}

extension Project: DocumentSerializable {
  init?(dictionary: [String : Any]) {
    guard let name = dictionary["name"] as? String,
    let completed = dictionary["completed"] as? Bool else { return nil }
    let contact = dictionary["contact"] == nil ? nil : dictionary["contact"] as? String
    
    self.init(contact: contact, name: name, completed: completed)
  }
}
