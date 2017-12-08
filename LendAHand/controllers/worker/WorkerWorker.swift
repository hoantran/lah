//
//  WorkerWorker.swift
//  LendAHand
//
//  Created by Hoan Tran on 12/5/17.
//  Copyright © 2017 Hoan Tran. All rights reserved.
//

import Foundation

extension WorkerViewController {
  func setupWorkers() {
    if let query = Constants.firestore.collection.workers {
      self.workers = LocalCollection(query: query) { [unowned self] (changes) in
        self.sort()
        DispatchQueue.main.async {
          self.tableView.reloadData()
        }
        self.checkEmptyViewVisibility()
      }
      self.workers.listen()
    }
  }
  
  func deinitWorkers() {
    if self.workers != nil {
      self.workers.stopListening()
    }
  }
}


protocol WorkerDataSourceDelegate: NSObjectProtocol {
  func exists(_ worker: Worker) -> Bool
}

extension WorkerViewController: WorkerDataSourceDelegate {
  func exists(_ worker: Worker) -> Bool {
    if self.workers.count > 0 {
      for i in 0...self.workers.count-1 {
        if worker == self.workers[i] {
          return true
        }
      }
    }
    return false
  }
}
