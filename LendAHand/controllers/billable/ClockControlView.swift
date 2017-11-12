//
//  ClockControlView.swift
//  LendAHand
//
//  Created by Hoan Tran on 11/9/17.
//  Copyright © 2017 Hoan Tran. All rights reserved.
//

import UIKit

protocol ClockControlDelegate: class {
  func tapped()
}

class ClockControlView: UIView {
  weak var delegate: ClockControlDelegate?
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    backgroundColor = UIColor.white
    
    addSubview(separator)
    NSLayoutConstraint.activate([
      separator.topAnchor.constraint(equalTo: topAnchor),
      separator.leftAnchor.constraint(equalTo: leftAnchor),
      separator.heightAnchor.constraint(equalToConstant: 1),
      separator.widthAnchor.constraint(equalTo: widthAnchor)
      ])
    
    addSubview(clock)
    NSLayoutConstraint.activate([
      clock.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 1),
      clock.leftAnchor.constraint(equalTo: leftAnchor, constant: 18),
      clock.widthAnchor.constraint(equalToConstant: 140),
      clock.heightAnchor.constraint(equalToConstant: 40)
      ])
    
    addSubview(control)
    NSLayoutConstraint.activate([
      control.centerYAnchor.constraint(equalTo: clock.centerYAnchor),
      control.rightAnchor.constraint(equalTo: rightAnchor, constant: -18),
      control.widthAnchor.constraint(equalToConstant: 170),
      control.heightAnchor.constraint(equalToConstant: 40)
      ])
    
    showClockIn()
    
//    addConstraints(format: "V:|-[v0(1)]-[v1(25)]-|", views: separator, clock)
//    addConstraints(format: "H:|-8-[v0(100)]-20-[v1(100)]-8-|", views: clock, control)
//    NSLayoutConstraint.activate([
//      control.centerYAnchor.constraint(equalTo: clock.centerYAnchor)
//      ])
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  let separator: UIView = {
    let s = UIView()
    s.translatesAutoresizingMaskIntoConstraints = false
    s.backgroundColor = UIColor.gray
    return s
  }()
  
  let clock: UILabel = {
    let label = UILabel()
    label.text = "00:00:00"
    label.font = UIFont.systemFont(ofSize: 26, weight: .ultraLight)
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  func update(_ elapsed: String) {
    clock.text = elapsed
  }
  
  func clear() {
    clock.text = "00:00:00"
  }
  
  let control: UIButton = {
    let b = UIButton()
    b.translatesAutoresizingMaskIntoConstraints = false
//    b.setTitle("CLOCK IN", for: .normal)
//    b.backgroundColor = UIColor.green
    b.setTitle("CLOCK OUT", for: .normal)
    b.backgroundColor = UIColor.red
    b.titleLabel?.font = UIFont.boldSystemFont(ofSize: 24)
//    b.titleLabel?.textAlignment = .center
    b.setTitleColor(UIColor.white, for: .normal)
    b.addTarget(self, action: #selector(handleControlTap), for: .touchUpInside)
    b.contentHorizontalAlignment = .center
    b.layer.cornerRadius = 5
    b.layer.borderWidth = 1
    b.layer.borderColor = UIColor.clear.cgColor
    return b
  }()
  
  func showClockIn() {
    control.setTitle("CLOCK IN", for: .normal)
    control.backgroundColor = UIColor.green
  }
  
  func showClockOut() {
    control.setTitle("CLOCK OUT", for: .normal)
    control.backgroundColor = UIColor.red
  }
  
  @objc func handleControlTap() {
    delegate?.tapped()
  }
}
