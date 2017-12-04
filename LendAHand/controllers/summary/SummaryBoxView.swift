//
//  SummaryBoxView.swift
//  LendAHand
//
//  Created by Hoan Tran on 12/4/17.
//  Copyright © 2017 Hoan Tran. All rights reserved.
//

import UIKit

class SummaryBoxView: UIView {
  
  var duration: Int? {
    didSet {
      if let seconds = duration {
        let hrs = Int(seconds/(60 * 60))
        let mins = Int((seconds - (hrs * 60 * 60))/60)
        durationLabel.text = String(format: "%d h %02d", hrs, mins)
      }
    }
  }
  
  var amount: Float? {
    didSet {
      if let amount = amount {
        amountLabel.text = amount.roundedTo(places: 2)
      }
    }
  }
  
  func setDates(earliest: Date, latest: Date) {
    let dayTimePeriodFormatter = DateFormatter()
    dayTimePeriodFormatter.dateFormat = "MMM dd, YYYY"
    
    switch earliest.compare(latest) {
    case .orderedAscending:
      let from = dayTimePeriodFormatter.string(from: earliest)
      let to = dayTimePeriodFormatter.string(from: latest)
      if from == to {
        dateLabel.text = from
      } else {
        dateLabel.text = from + " - " + to
      }
    case .orderedSame:
      dateLabel.text = dayTimePeriodFormatter.string(from: earliest)
    case .orderedDescending:
      print("Err: earliest date and latest date should be the same or ascending")
    }
    
  }
  
  private let durationLabel: UILabel = {
    let label = UILabel()
    label.text = "0 h 00'"
    //    label.font = UIFont.systemFont(ofSize: 14, weight: .ultraLight)
    label.font = UIFont.monospacedDigitSystemFont(ofSize: 18, weight: .ultraLight)
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
    label.font = UIFont.systemFont(ofSize: 24)
    label.textAlignment = .left
    return label
  }()
  
  private let dateLabel: UILabel = {
    let label = UILabel()
    label.text = "-"
    label.font = UIFont.systemFont(ofSize: 12, weight: .ultraLight)
    label.translatesAutoresizingMaskIntoConstraints = false
    label.textAlignment = .center
    label.textColor = UIColor.gray
    return label
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    backgroundColor = UIColor(hex: "0Xf8f8e6")
    
    addSubview(durationLabel)
    addSubview(separator)
    addSubview(amountLabel)
    addSubview(dateLabel)

    addConstraints(format: "H:|[v0(==v2)]-[v1(1)]-[v2(==v0)]|", views: durationLabel, separator, amountLabel)
    addConstraints(format: "H:|[v0]|", views: dateLabel)
    addConstraints(format: "V:|[v0(==v1)][v1(==v0)]|", views: durationLabel, dateLabel)
    
    NSLayoutConstraint.activate([
      separator.centerYAnchor.constraint(equalTo: durationLabel.centerYAnchor),
      separator.heightAnchor.constraint(equalTo: durationLabel.heightAnchor),
      
      amountLabel.centerYAnchor.constraint(equalTo: durationLabel.centerYAnchor),
      amountLabel.heightAnchor.constraint(equalTo: durationLabel.heightAnchor),
      ])
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
