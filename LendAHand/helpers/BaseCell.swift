//
//  BaseCell.swift
//  LendAHand
//
//  Created by Hoan Tran on 11/8/17.
//  Copyright © 2017 Hoan Tran. All rights reserved.
//

import UIKit

class BaseCell: UITableViewCell {
  
  override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    setupViews()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func setupViews(){}
}
