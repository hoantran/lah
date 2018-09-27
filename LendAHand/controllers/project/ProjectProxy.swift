//
//  ProjectProxy.swift
//  LendAHand
//
//  Created by Hoan Tran on 11/8/17.
//  Copyright © 2017 Hoan Tran. All rights reserved.
//

import Foundation

extension Notification.Name {
  static let projectChanged = Notification.Name("projectChanged")
}

final class ProjectProxy: NSObject {
  var projects: LocalCollection<Project>!
  static let shared = ProjectProxy()
  
  private override init(){
    super.init()
    setupProjectObservation()
    self.projects.listen()
  }
  
  deinit {
    self.projects.stopListening()
  }
  
  func setupProjectObservation() {
    if let query = Constants.firestore.collection.projects {
      self.projects = LocalCollection(query: query) { (changes) in
        NotificationCenter.default.post(name: .projectChanged, object: nil, userInfo: nil)
      }
    }
  }
}

extension ProjectProxy {
  func getName(_ id: String) -> String? {
    return self.projects.retrieve(id)?.name
  }
}
