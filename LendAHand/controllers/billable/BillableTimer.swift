//
//  BillableTimer.swift
//  LendAHand
//
//  Created by Hoan Tran on 11/21/17.
//  Copyright © 2017 Hoan Tran. All rights reserved.
//

import UIKit

extension BillableViewController {
  func startTimer() {
    clearTimer()
    self.timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(timerFired), userInfo: nil, repeats: true)
  }
  
  func clearTimer() {
    self.timer?.invalidate()
    self.timer = nil
  }
  
  @objc func timerFired(timer: Timer) {
    updateClock()
  }
}
