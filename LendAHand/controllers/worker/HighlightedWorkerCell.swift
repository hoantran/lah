//
//  HighlightedWorkerCell.swift
//  LendAHand
//
//  Created by Hoan Tran on 11/10/17.
//  Copyright © 2017 Hoan Tran. All rights reserved.
//

import UIKit

class HighlightedWorkerCell: BaseCell {
  static let cellID = "HighlightedWorkerCell"
  var timer: Timer!
  var start: Date? {
    didSet {
      if let start = start {
        clock.start = start
        stats.start = start
        stats.name = "Pac Man"
        stats.rate = 10.05
      }
    }
  }
  
  var name: String? {
    didSet {
      if let name = name {
        stats.name = name
      }
    }
  }
  
  var rate: Float? {
    didSet {
      if let rate = rate {
        stats.rate = rate
      }
    }
  }

  
  let clock: ClockView = {
    let clk = ClockView()
    clk.translatesAutoresizingMaskIntoConstraints = false
    return clk
  } ()
  
  let stats: StatsView = {
    let sts = StatsView()
    sts.translatesAutoresizingMaskIntoConstraints = false
    return sts
  }()
  
  func update() {
    clock.update()
    stats.update()
  }
  
  override func prepareForReuse() {
    super.prepareForReuse()
    rate = 0
    name = "Francisco Roy"
    start = Date()
    print("Called prepareForReuse()")
  }
  
  override func setupViews() {
    addSubview(clock)
    NSLayoutConstraint.activate([
      clock.centerYAnchor.constraint(equalTo: centerYAnchor),
      clock.leftAnchor.constraint(equalTo: leftAnchor, constant: 25),
      clock.widthAnchor.constraint(equalToConstant: 60),
      clock.heightAnchor.constraint(equalToConstant: 60),
      ])
    
    addSubview(stats)
    NSLayoutConstraint.activate([
      stats.centerYAnchor.constraint(equalTo: centerYAnchor),
      stats.rightAnchor.constraint(equalTo: rightAnchor, constant: -25),
      stats.widthAnchor.constraint(equalToConstant: 150),
      stats.heightAnchor.constraint(equalToConstant: 50),
      ])
    
    moreSetups()
  }
  
  deinit {
    moreDeinits()
  }

}

extension HighlightedWorkerCell {
  func moreSetups() {
    self.timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(timerFired), userInfo: nil, repeats: true)
  }
 
  func moreDeinits() {
    self.timer?.invalidate()
    self.timer = nil
  }
  
  @objc func timerFired(timer: Timer) {
    self.update()
  }
}





