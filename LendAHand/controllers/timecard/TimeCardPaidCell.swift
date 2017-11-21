//
//  TimeCardPaidCell.swift
//  LendAHand
//
//  Created by Hoan Tran on 11/21/17.
//  Copyright © 2017 Hoan Tran. All rights reserved.
//

import UIKit

class TimeCardPaidCell: BaseCell {
  static let cellID = "TimeCardPaidCell"
  
  var updateHandler: ((Bool)->())?
  
  var title: String? {
    didSet {
      if let title = self.title {
        titleLabel.text = title
      }
    }
  }
  
  var state: Bool? {
    didSet {
      if let state = self.state {
        self.switchControl.isOn = state
      }
    }
  }
  
  override func prepareForReuse() {
    self.title = nil
    self.state = nil
  }
  
  let titleLabel: UILabel = {
    let label = UILabel()
    label.text = "PAID"
    label.textAlignment = .left
    label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  let switchControl: UISwitch = {
    let control = UISwitch()
    control.isOn = false
    control.setOn(false, animated: true)
//    control.tintColor = UIColor.cyan
    control.onTintColor = UIColor.red
//    control.thumbTintColor = UIColor.brown
//    control.backgroundColor = UIColor.blue
    control.addTarget(self, action: #selector(handleSwitchChange), for: .valueChanged)
    control.translatesAutoresizingMaskIntoConstraints = false
    return control
  }()
  
  @objc func handleSwitchChange() {
    if let handler = updateHandler {
      handler(self.switchControl.isOn)
    }
  }
  
  override func setupViews() {
    addSubview(titleLabel)
    addSubview(switchControl)
    
    NSLayoutConstraint.activate([
      titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
      titleLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: Constants.margin.left),
      titleLabel.widthAnchor.constraint(equalToConstant: 100),
      titleLabel.heightAnchor.constraint(lessThanOrEqualTo: heightAnchor),
      ])
    
    NSLayoutConstraint.activate([
      switchControl.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),
      switchControl.rightAnchor.constraint(equalTo: rightAnchor, constant: -Constants.margin.right),
      switchControl.widthAnchor.constraint(equalToConstant: 55),
      switchControl.heightAnchor.constraint(equalTo: titleLabel.heightAnchor),
      ])
  }
}
