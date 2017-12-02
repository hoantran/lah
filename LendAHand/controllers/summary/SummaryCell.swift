//
//  SummaryCell.swift
//  LendAHand
//
//  Created by Hoan Tran on 12/1/17.
//  Copyright © 2017 Hoan Tran. All rights reserved.
//

import UIKit

class SummaryCell: BaseCell {
  static let cellID = "SummaryCell"
  
  var duration: String? {
    didSet {
      self.durationLabel.text = duration
    }
  }
  
  var amount: String? {
    didSet {
      self.amountLabel.text = amount
    }
  }
  
  override func prepareForReuse() {
    duration = nil
    amount = nil
  }

  
  private let container: UIView = {
    let v = UIView()
    v.translatesAutoresizingMaskIntoConstraints = false
    return v
  }()
  
  private let durationLabel: UILabel = {
    let label = UILabel()
    label.text = "0 h 00'"
//    label.font = UIFont.systemFont(ofSize: 14, weight: .ultraLight)
    label.font = UIFont.monospacedDigitSystemFont(ofSize: 14, weight: .ultraLight)
    label.translatesAutoresizingMaskIntoConstraints = false
    label.textAlignment = .right
    return label
  }()
  
  private let separator: UIView = {
    let v = UIView()
    v.translatesAutoresizingMaskIntoConstraints = false
    v.backgroundColor = UIColor(hex: "0Xe5e5e5")
    return v
  }()
  
  private let amountLabel: UILabel = {
    let label = UILabel()
    label.text = "00.00"
    label.translatesAutoresizingMaskIntoConstraints = false
    label.textColor = UIColor.orange
    label.font = UIFont.boldSystemFont(ofSize: 18)
    label.textAlignment = .right
    return label
  }()

  
  override func setupViews() {
    super.setupViews()
    
    addSubview(container)
    NSLayoutConstraint.activate([
      container.rightAnchor.constraint(equalTo: rightAnchor, constant: -12),
      container.centerYAnchor.constraint(equalTo: centerYAnchor),
      container.widthAnchor.constraint(equalToConstant: 180),
      container.heightAnchor.constraint(equalTo: heightAnchor)
      ])
    
    container.addSubview(durationLabel)
    container.addSubview(separator)
    container.addSubview(amountLabel)
    
    NSLayoutConstraint.activate([
      amountLabel.rightAnchor.constraint(equalTo: container.rightAnchor),
      amountLabel.centerYAnchor.constraint(equalTo: container.centerYAnchor),
      amountLabel.heightAnchor.constraint(equalTo: container.heightAnchor),
      amountLabel.widthAnchor.constraint(equalToConstant: 100),
      
      separator.rightAnchor.constraint(equalTo: amountLabel.leftAnchor, constant: -1),
      separator.centerYAnchor.constraint(equalTo: container.centerYAnchor),
      separator.heightAnchor.constraint(equalTo: container.heightAnchor, constant: -16),
      separator.widthAnchor.constraint(equalToConstant: 1),
      
      durationLabel.rightAnchor.constraint(equalTo: separator.leftAnchor, constant: -3),
      durationLabel.centerYAnchor.constraint(equalTo: container.centerYAnchor),
      durationLabel.heightAnchor.constraint(equalTo: container.heightAnchor),
      durationLabel.leftAnchor.constraint(equalTo: container.leftAnchor),
      ])
    
  }
}
