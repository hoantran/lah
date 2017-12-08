//
//  StatsView.swift
//  LendAHand
//
//  Created by Hoan Tran on 11/10/17.
//  Copyright © 2017 Hoan Tran. All rights reserved.
//

import UIKit

class StatsView: UIView {
  var rate:Float = 0.00 {
    didSet {
      rateLabel.text = rate.roundedTo(places: 2) + "/hr"
      calcAmount()
    }
  }
  
  var start: Date = Date() {
    didSet {
      calcAmount()
    }
  }
  
  var name: String = "Francisca Do" {
    didSet {
      nameLabel.text = name
    }
  }
  
  func update() {
    calcAmount()
  }
  
  func calcAmount() {
    let now = Date()
    let elapsed = Float(now.timeIntervalSince(start))
    let earned = (elapsed/3600) * rate
    amount.text = earned.roundedTo(places: 2)
  }
  
  var dollar: UILabel = {
    let label = UILabel()
    label.text = "$"
    label.font = UIFont.systemFont(ofSize: 20, weight: .light)
    label.textColor = Constants.color.amount
    label.backgroundColor = UIColor.clear
    label.textAlignment = .right
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  var amount: UILabel = {
    let label = UILabel()
    label.text = "49876.45"
    label.font = UIFont.systemFont(ofSize: 24, weight: .medium)
    label.textColor = Constants.color.amount
    label.backgroundColor = UIColor.clear
    label.textAlignment = .right
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  var nameLabel: UILabel = {
    let label = UILabel()
    label.text = "Francisca Do"
    label.font = UIFont.systemFont(ofSize: 14, weight: .light)
    label.textColor = UIColor.black
    label.backgroundColor = UIColor.clear
    label.textAlignment = .right
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  var rateLabel: UILabel = {
    let label = UILabel()
    label.text = "7.85/h"
    label.font = UIFont.systemFont(ofSize: 10, weight: .bold)
    label.textColor = UIColor.black
    label.backgroundColor = UIColor.clear
    label.textAlignment = .right
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()

  
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    addSubview(amount)
    addSubview(dollar)
    addSubview(nameLabel)
    addSubview(rateLabel)
    
    addConstraints(format: "H:|-[v0]-8-[v1]|", views: dollar, amount)
    NSLayoutConstraint.activate([
      amount.topAnchor.constraint(equalTo: topAnchor, constant: 0),
//      amount.rightAnchor.constraint(equalTo: rightAnchor),
//      amount.leftAnchor.constraint(equalTo: dollar.rightAnchor, constant: -4),
//      amount.widthAnchor.constraint(equalTo: widthAnchor, constant: -25),
      amount.heightAnchor.constraint(equalToConstant: 30),
      
      dollar.centerYAnchor.constraint(equalTo: amount.centerYAnchor),
//      dollar.leftAnchor.constraint(equalTo: leftAnchor, constant: 0),
//      dollar.rightAnchor.constraint(equalTo: amount.leftAnchor, constant: 0),
//      dollar.widthAnchor.constraint(equalToConstant: 20),
//      dollar.widthAnchor.constraint(equalToConstant: 20),
      dollar.heightAnchor.constraint(equalTo: amount.heightAnchor),
      
      nameLabel.topAnchor.constraint(equalTo: amount.bottomAnchor, constant: -1),
      nameLabel.rightAnchor.constraint(equalTo: rightAnchor),
      nameLabel.widthAnchor.constraint(equalTo: widthAnchor),
      nameLabel.heightAnchor.constraint(equalToConstant: 10),

      rateLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 5),
      rateLabel.rightAnchor.constraint(equalTo: rightAnchor),
      rateLabel.widthAnchor.constraint(equalTo: widthAnchor),
      rateLabel.heightAnchor.constraint(equalToConstant: 10),
      ])
    
    
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
