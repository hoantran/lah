//
//  BillableCell.swift
//  LendAHand
//
//  Created by Hoan Tran on 11/8/17.
//  Copyright © 2017 Hoan Tran. All rights reserved.
//

import UIKit

class BillableCell: BaseCell {
  var work:Work? {
    didSet {
      if let work = self.work {
        if let prj = work.project {
          project.text = ProjectProxy.shared.getName(prj)
        } else {
          project.text = String(work.start.timeIntervalSince1970)
        }
        paid.isHidden = !work.isPaid
        
        if let duration = work.duration() {
          self.duration.text = duration
        }
        
        let dayTimePeriodFormatter = DateFormatter()
        dayTimePeriodFormatter.dateFormat = "MMM dd, YYYY"
        self.date.text = dayTimePeriodFormatter.string(from: work.start)
        
        if let payable = work.payable(false) {
          amount.text = payable
        } else {
          amount.text = ""
        }
      }
    }
  }
  
  static let cellID = "billableCellID"
  let project: UILabel = {
    let label = UILabel()
    label.text = "Project's name"
    label.font = UIFont.boldSystemFont(ofSize: 17)
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  let paid: UILabel = {
    let label = UILabel()
    label.text = "PAID"
    label.textColor = UIColor(hex: "0xff474a")
    label.textAlignment = .right
    label.translatesAutoresizingMaskIntoConstraints = false
    label.isHidden = true
    return label
  }()
  
  let duration: UILabel = {
    let label = UILabel()
    label.text = "0h00'"
    label.font = UIFont.systemFont(ofSize: 10, weight: .light)
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  let date: UILabel = {
    let label = UILabel()
    label.text = "000 0, 0000"
    label.font = UIFont.systemFont(ofSize: 10, weight: .light)
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  let amount: UILabel = {
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
    
    addSubview(project)
    addSubview(paid)
    addSubview(duration)
    addSubview(date)
    addSubview(amount)
    
    //    addConstraints(format: "H:|-8-[v0(>=130)]-4-[v1(50)]-4-[v2(75)]-[v3(<=85)]-8-|", views: project, paid, duration, amount)
    NSLayoutConstraint.activate([
      amount.rightAnchor.constraint(equalTo: rightAnchor, constant: -8),
      amount.widthAnchor.constraint(equalToConstant: 80),
      duration.rightAnchor.constraint(equalTo: amount.leftAnchor, constant: -2),
      duration.widthAnchor.constraint(equalToConstant: 70),
      paid.rightAnchor.constraint(equalTo: duration.leftAnchor, constant: -4),
      paid.widthAnchor.constraint(equalToConstant: 50),
      project.leftAnchor.constraint(equalTo: leftAnchor, constant: 8),
      project.rightAnchor.constraint(equalTo: paid.leftAnchor, constant: -4)
      ])
    
    addConstraints(format: "V:|-[v0]-|", views: project)
    addConstraints(format: "V:|-[v0]-|", views: paid)
    addConstraints(format: "V:|-[v0]-|", views: amount)
    
    let cellHalfHeight = frame.height/2
    NSLayoutConstraint.activate([
      date.leftAnchor.constraint(equalTo: duration.leftAnchor),
      duration.bottomAnchor.constraint(equalTo: topAnchor, constant: cellHalfHeight-2),
      date.topAnchor.constraint(equalTo: duration.bottomAnchor, constant: 4)
      ])
//    addConstraints(format: "V:|[v0]-4-[v1]|", views: duration, date)

  }
}
