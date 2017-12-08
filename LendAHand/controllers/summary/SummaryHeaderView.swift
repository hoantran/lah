//
//  SummaryHeaderView.swift
//  LendAHand
//
//  Created by Hoan Tran on 12/3/17.
//  Copyright © 2017 Hoan Tran. All rights reserved.
//

import UIKit

class SummaryHeaderView: UITableViewHeaderFooterView {
  static let headerID = "SummaryHeaderView"
  
  var tapHandler: ( (Int)->Void )?
  var section: Int?
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
  
  var worker: String? {
    didSet {
      self.workerLabel.text = worker
    }
  }

  override func prepareForReuse() {
    tapHandler = nil
    section = nil
    duration = nil
    amount = nil
    worker = nil
  }
  
  let separatorTop: UIView = {
    let s = UIView()
    s.translatesAutoresizingMaskIntoConstraints = false
    s.backgroundColor = UIColor(hex: "0xd6d6d6")
    return s
  }()
  
  lazy var container: UIView = {
    let v = UIView()
    v.translatesAutoresizingMaskIntoConstraints = false
    let gesture = UITapGestureRecognizer(target: self, action: #selector(handleSectionTap))
    gesture.numberOfTapsRequired = 1
    v.isUserInteractionEnabled = true
    v.addGestureRecognizer(gesture)
    return v
  }()
  
  @objc func handleSectionTap() {
    if let section = section {
      tapHandler?(section)
    }
  }
  
  private let workerLabel: UILabel = {
    let label = UILabel()
//    label.text = "RATE ($/hr)"
    label.textAlignment = .left
    label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
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
  
  
  override init(reuseIdentifier: String?) {
    super.init(reuseIdentifier: reuseIdentifier)
    
    addSubview(separatorTop)
    NSLayoutConstraint.activate([
      separatorTop.centerXAnchor.constraint(equalTo: centerXAnchor),
      separatorTop.topAnchor.constraint(equalTo: topAnchor, constant: -1),
      separatorTop.widthAnchor.constraint(equalTo: widthAnchor),
      separatorTop.heightAnchor.constraint(equalToConstant: 1),
      ])
    
    addSubview(container)
    NSLayoutConstraint.activate([
      container.centerXAnchor.constraint(equalTo: centerXAnchor),
      container.centerYAnchor.constraint(equalTo: centerYAnchor),
      container.widthAnchor.constraint(equalTo: widthAnchor),
      container.heightAnchor.constraint(equalTo: heightAnchor),
      ])
    
    container.addSubview(workerLabel)
    container.addSubview(durationLabel)
    container.addSubview(separator)
    container.addSubview(amountLabel)
    
    NSLayoutConstraint.activate([
      amountLabel.rightAnchor.constraint(equalTo: container.rightAnchor, constant: -8),
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
      
      workerLabel.rightAnchor.constraint(equalTo: durationLabel.leftAnchor, constant: -3),
      workerLabel.centerYAnchor.constraint(equalTo: container.centerYAnchor),
      workerLabel.heightAnchor.constraint(equalTo: container.heightAnchor),
      workerLabel.leftAnchor.constraint(equalTo: container.leftAnchor, constant: 8),
      
      ])
    
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}
