//
//  ProjectBurgerMenu.swift
//  LendAHand
//
//  Created by Hoan Tran on 11/30/17.
//  Copyright © 2017 Hoan Tran. All rights reserved.
//

import UIKit

extension ProjectViewController {
  func setupBurgerButton() {
    let button = UIButton()
    button.setImage(UIImage(named: "menu.png"), for: .normal)
    addTarget(button)
    let barItem = UIBarButtonItem(customView: button)
    
    if  let width = barItem.customView?.widthAnchor.constraint(equalToConstant: 22),
      let height = barItem.customView?.heightAnchor.constraint(equalToConstant: 22) {
      width.isActive = true
      height.isActive = true
    }
    
    navigationItem.leftBarButtonItem = barItem
  }
  
  func addTarget(_ btn: UIButton) {
    btn.addTarget(self, action: #selector(handleBugerButtonTap), for: .touchUpInside)
  }
  
  @objc func handleBugerButtonTap() {
    postMenuTapped()
  }
  
  func postMenuTapped() {
    NotificationCenter.default.post(name: .menuTapped, object: nil)
  }
}
