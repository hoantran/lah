//
//  BillableClockDelegate.swift
//  LendAHand
//
//  Created by Hoan Tran on 11/21/17.
//  Copyright © 2017 Hoan Tran. All rights reserved.
//

import UIKit

extension BillableViewController: ClockControlDelegate {
  
  func updateClock() {
    if let index = currentIndex() {
      let current = self.currents[index]
      control.update(current.start.elapsed())
    }
  }
  
  func updateControl() {
    if isOnTheClock() {
      control.showClockOut()
      startTimer()
    } else {
      control.showClockIn()
      clearTimer()
      control.clear()
    }
  }
  
  func currentIndex()->Int? {
    if let workerID = self.workerID {
      if let currents = self.currents {
        if currents.count > 0 {
          for i in 0...currents.count - 1 {
            if workerID == currents[i].worker {
              return i
            }
          }
        }
      }
    } else {
      print ("Err: workerID is not set")
    }
    return nil
  }
  
  func isOnTheClock()->Bool {
    if currentIndex() == nil {
      return false
    } else {
      return true
    }
  }
  
  func tapped() {
    if isOnTheClock() {
      clockOut()
    } else {
      clockIn()
    }
  }
  
  func clockIn() {
    self.control.showClockOut()
    if let workerID = self.workerID, let worker = self.worker {
      let current = Current(
        worker: workerID,
        start: Date(),
        rate: worker.rate
        )
      Constants.firestore.collection.currents?.addDocument(data: current.dictionary)
    } else {
      print ("Err: worker identity attributes are not set")
    }
  }
  
  func clockOut() {
    self.control.showClockIn()
    if let index = currentIndex() {
      if let currentID = self.currents.id(index) {
        let current = self.currents[index]
        //
        Constants.firestore.collection.currents?.document(currentID).delete() { err in
          if let err = err {
            print("Err while deleting \(currentID): \(err)")
          }
        }
        
        //
        if let worker = self.worker, let workerID = self.workerID {
          let work = Work(rate: worker.rate, isPaid: false, start: current.start, worker: workerID, project: nil, stop: Date(), note: nil)
          Constants.firestore.collection.works?.addDocument(data: work.dictionary)
        } else {
          print ("Err: worker is not set; can save this work period")
        }
        
      }
    } else {
      print ("Err: can not index of the current entry")
    }
  }
  
  func setupCurrents() {
    if let query = Constants.firestore.collection.currents {
      self.currents = LocalCollection(query: query) { [unowned self] (changes) in
        //      changes.forEach(){ print ("[", $0.type, "]", $0) }
        self.updateControl()
      }
      self.currents.listen()
    }
  }
  
  func deinitCurrents() {
    if let currents = self.currents {
      currents.stopListening()
      self.currents = nil
    }
  }
}
