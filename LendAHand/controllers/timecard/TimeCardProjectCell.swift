//
//  TimeCardProjectCell.swift
//  LendAHand
//
//  Created by Hoan Tran on 11/21/17.
//  Copyright © 2017 Hoan Tran. All rights reserved.
//

import UIKit

class TimeCardProjectCell: BaseCell {
  static let cellID = "TimeCardProjectCell"
  
  var tapHandler: (()->())?
  
  var title: String? {
    didSet {
      if let title = self.title {
        titleLabel.text = title
      }
    }
  }
  
  var project: String? {
    didSet {
      if let project = self.project {
        self.button.setTitle(project, for: .normal)
      }
    }
  }
  
  override func prepareForReuse() {
    self.title = nil
    self.project = nil
  }
  
  let titleLabel: UILabel = {
    let label = UILabel()
    label.text = "PROJECT"
    label.textAlignment = .left
    label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  lazy var button: UIButton = {
    let b = UIButton()
    b.translatesAutoresizingMaskIntoConstraints = false
    if let project = self.project {
      b.setTitle(project, for: .normal)
    } else {
      b.setTitle("no project", for: .normal)
    }
//    b.backgroundColor = UIColor.red
    b.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .light)
    b.setTitleColor(UIColor.black, for: .normal)
    b.contentHorizontalAlignment = .right
//    b.layer.cornerRadius = 5
//    b.layer.borderWidth = 1
//    b.layer.borderColor = UIColor.clear.cgColor
    b.addTarget(self, action: #selector(handleTap), for: .touchUpInside)
    return b
  }()
  
  @objc func handleTap() {
    print("tap")
    if let project = self.project {
      button.setTitle(project, for: .normal)
    }
    if let handler = tapHandler {
      handler()
    }
  }
  
  override func setupViews() {
    addSubview(titleLabel)
    addSubview(button)
    
    NSLayoutConstraint.activate([
      titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
      titleLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: Constants.margin.left),
      titleLabel.widthAnchor.constraint(equalToConstant: 100),
      titleLabel.heightAnchor.constraint(lessThanOrEqualTo: heightAnchor),
      ])
    
    NSLayoutConstraint.activate([
      button.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),
      button.rightAnchor.constraint(equalTo: rightAnchor, constant: -Constants.margin.right - 3),
      button.leftAnchor.constraint(equalTo: titleLabel.rightAnchor, constant: 8),
      button.heightAnchor.constraint(equalTo: titleLabel.heightAnchor),
      ])
    
    didSelectHandler = handleTap
  }
}
