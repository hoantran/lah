//
//  TimeCardTitleValueCell.swift
//  LendAHand
//
//  Created by Hoan Tran on 11/17/17.
//  Copyright © 2017 Hoan Tran. All rights reserved.
//

import UIKit

class TimeCardTitleValueCell: BaseCell {
  static let cellID = "TimeCardTitleValueCell"
  
  var title: String? {
    didSet {
      if let title = self.title {
        titleLabel.text = title
      }
    }
  }
  
  var value: String? {
    didSet {
      if let value = self.value {
        valueLabel.text = value
      }
    }
  }
  
  override func prepareForReuse() {
    self.title = nil
    self.value = nil
  }
  
  let titleLabel: UILabel = {
    let label = UILabel()
    label.text = "DURATION"
    label.textAlignment = .left
    label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  let valueLabel: UILabel = {
    let label = UILabel()
    label.text = "0 hrs 0 mins"
    label.textAlignment = .right
    label.font = UIFont.systemFont(ofSize: 18, weight: .light)
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  override func setupViews() {
    addSubview(titleLabel)
    addSubview(valueLabel)
    
    NSLayoutConstraint.activate([
      titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
      titleLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: Constants.margin.left),
      titleLabel.rightAnchor.constraint(lessThanOrEqualTo: valueLabel.leftAnchor),
      titleLabel.heightAnchor.constraint(lessThanOrEqualTo: heightAnchor),
      ])
    
    NSLayoutConstraint.activate([
      valueLabel.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),
      valueLabel.leftAnchor.constraint(lessThanOrEqualTo: titleLabel.rightAnchor, constant: 0),
      valueLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -Constants.margin.right),
      valueLabel.heightAnchor.constraint(equalTo: titleLabel.heightAnchor),
      ])
  }
}
