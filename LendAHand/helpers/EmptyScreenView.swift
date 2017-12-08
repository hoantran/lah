//
//  EmptyScreenView.swift
//  LendAHand
//
//  Created by Hoan Tran on 12/7/17.
//  Copyright © 2017 Hoan Tran. All rights reserved.
//

import UIKit

class EmptyScreenView: UIView {

  var message: String = "" {
    didSet {
      DispatchQueue.main.async {
        self.msgLabel.text = self.message
      }
    }
  }
  
  private let bkgView: UIView = {
    let v = UIView()
    v.translatesAutoresizingMaskIntoConstraints = false
    v.backgroundColor = UIColor.white
    return v
  }()
  
  private var msgLabel: UILabel = {
    let label = UILabel()
    label.text = ""
    label.font = UIFont.systemFont(ofSize: 32, weight: .ultraLight)
    label.textColor = UIColor.gray
    label.backgroundColor = UIColor.white
    label.textAlignment = .center
    label.translatesAutoresizingMaskIntoConstraints = false
    label.lineBreakMode = .byWordWrapping
    label.numberOfLines = 0
    return label
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    addSubview(bkgView)
    NSLayoutConstraint.activate([
      bkgView.centerXAnchor.constraint(equalTo: centerXAnchor),
      bkgView.centerYAnchor.constraint(equalTo: centerYAnchor),
      bkgView.widthAnchor.constraint(equalTo: widthAnchor),
      bkgView.heightAnchor.constraint(equalTo: heightAnchor)
      ])
    
    addSubview(msgLabel)
    NSLayoutConstraint.activate([
      msgLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
      msgLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -100),
      msgLabel.widthAnchor.constraint(equalTo: widthAnchor, constant: -100),
      msgLabel.heightAnchor.constraint(equalTo: heightAnchor, constant: -50)
    ])
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
