//
//  SummaryCell.swift
//  LendAHand
//
//  Created by Hoan Tran on 12/1/17.
//  Copyright © 2017 Hoan Tran. All rights reserved.
//

import UIKit

// http://alisoftware.github.io/swift/generics/2016/01/06/generic-tableviewcells/
// https://cocoapods.org/pods/Reusable
//import Resusable

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
  
  var isPaid: Bool? {
    didSet {
      if let isPaid = isPaid {
        paidLabel.isHidden = !isPaid
      }
    }
  }
  
  override func prepareForReuse() {
    duration = nil
    amount = nil
    isPaid = nil
  }
  
  
  private let container: UIView = {
    let v = UIView()
    v.translatesAutoresizingMaskIntoConstraints = false
    return v
  }()
  
  let paidLabel: UILabel = {
    let label = UILabel()
    label.text = "PAID"
    label.textColor = UIColor(hex: "0xff474a")
    label.textAlignment = .right
    label.translatesAutoresizingMaskIntoConstraints = false
    label.isHidden = true
    return label
  }()
  
  private let durationLabel: UILabel = {
    let label = UILabel()
    label.text = "0 h 00'"
//    label.font = UIFont.systemFont(ofSize: 14, weight: .ultraLight)
    label.font = UIFont.monospacedDigitSystemFont(ofSize: 14, weight: .ultraLight)
    label.translatesAutoresizingMaskIntoConstraints = false
    label.textAlignment = .right
    label.textColor = UIColor.gray
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
    label.font = UIFont.systemFont(ofSize: 18)
    label.textAlignment = .right
    return label
  }()

  
  override func setupViews() {
    super.setupViews()
    
    addSubview(container)
    NSLayoutConstraint.activate([
      container.rightAnchor.constraint(equalTo: rightAnchor, constant: -8),
      container.centerYAnchor.constraint(equalTo: centerYAnchor),
      container.widthAnchor.constraint(equalTo: widthAnchor),
      container.heightAnchor.constraint(equalTo: heightAnchor)
      ])
    
    container.addSubview(durationLabel)
    container.addSubview(separator)
    container.addSubview(amountLabel)
    container.addSubview(paidLabel)
    
    NSLayoutConstraint.activate([
      amountLabel.rightAnchor.constraint(equalTo: container.rightAnchor),
      amountLabel.centerYAnchor.constraint(equalTo: container.centerYAnchor),
      amountLabel.heightAnchor.constraint(equalTo: container.heightAnchor),
      amountLabel.widthAnchor.constraint(equalToConstant: 80),
      
      separator.rightAnchor.constraint(equalTo: amountLabel.leftAnchor, constant: -1),
      separator.centerYAnchor.constraint(equalTo: container.centerYAnchor),
      separator.heightAnchor.constraint(equalTo: container.heightAnchor, constant: -16),
      separator.widthAnchor.constraint(equalToConstant: 1),
      
      durationLabel.rightAnchor.constraint(equalTo: separator.leftAnchor, constant: -3),
      durationLabel.centerYAnchor.constraint(equalTo: container.centerYAnchor),
      durationLabel.heightAnchor.constraint(equalTo: container.heightAnchor),
      durationLabel.widthAnchor.constraint(equalToConstant: 70),
      
      paidLabel.rightAnchor.constraint(equalTo: durationLabel.leftAnchor, constant: -3),
      paidLabel.centerYAnchor.constraint(equalTo: container.centerYAnchor),
      paidLabel.heightAnchor.constraint(equalTo: container.heightAnchor),
      paidLabel.widthAnchor.constraint(equalToConstant: 50),
      ])
    
  }
}
