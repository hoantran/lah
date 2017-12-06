//
//  WorkerCurrent.swift
//  LendAHand
//
//  Created by Hoan Tran on 12/5/17.
//  Copyright © 2017 Hoan Tran. All rights reserved.
//

import Foundation


extension WorkerViewController {
  
  func getWorkerInCurrents(_ workerID: String?) -> Current? {
    guard let workerID = workerID else { return nil }
    if self.currents != nil && self.currents.count > 0{
      for i in 0..<self.currents.count {
        let worker = self.currents[i]
        if workerID == worker.worker {
          return worker
        }
      }
    }
    return nil
  }
  
  func sort() {
    var allCounts: [Int] = Array(repeating:0, count: self.workers.count)
    for (i, _) in allCounts.enumerated() {
      allCounts[i] = i
    }
    
    var newHightlighted = [Int]()
    let newNormals = allCounts.filter { el in
      if let workerID = self.workers.id(el) {
        if isInCurrents(workerID) {
          newHightlighted.append(el)
          return false
        }
      }
      return true
    }
    
    if self.contactAccessPermission {
      self.indexOrder = nameSort(newHightlighted) + nameSort(newNormals)
    } else {
      self.indexOrder = newHightlighted + newNormals
    }
  }
  
  private func nameSort(_ set: [Int])->[Int] {
    return set.sorted() { one, two in
      if  let name1 = ContactMgr.shared.getName(self.workers[one].contact),
        let name2 = ContactMgr.shared.getName(self.workers[two].contact) {
        return name1 < name2
      }
      else {
        return false
      }
    }
  }
  
  func isHighlightedRow(_ row: Int)->Bool {
    return row < self.currents.count
  }
  
  
  func setupCurrents() {
    if let query = Constants.firestore.collection.currents {
      self.currents = LocalCollection(query: query) { [unowned self] (changes) in
        self.sort()
        DispatchQueue.main.async {
          self.tableView.reloadData()
        }
      }
      self.currents.listen()
    }
  }
  
  func deinitCurrents() {
    if self.currents != nil {
      self.currents.stopListening()
    }
  }
  
  func currentID(_ workerID: String)->String? {
    if self.currents.count > 0 {
      for i in 0...self.currents.count-1 {
        if workerID == self.currents[i].worker {
          return self.currents.id(i)
        }
      }
    }
    return nil
  }
  
  func isInCurrents(_ workerID: String)->Bool {
    return currentID(workerID) != nil
  }
}

