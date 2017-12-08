//
//  BurgerButton.swift
//  LendAHand
//
//  Created by Hoan Tran on 11/2/17.
//  Copyright © 2017 Hoan Tran. All rights reserved.
//

import UIKit

protocol BurgerButton {
  func setupBurgerButton()
  func addTarget(_ btn: UIButton)
  func postMenuTapped()
}

extension BurgerButton where Self: UIViewController {
  func setupBurgerButton() {
    let button = UIButton()
    button.setImage(UIImage(named: "menu.png"), for: .normal)
    addTarget(button)
//    can NOT expose protocol func to @objc
//    button.addTarget(self, action: #selector(handleBugerButtonTap), for: .touchUpInside)
    let barItem = UIBarButtonItem(customView: button)
    
    if  let width = barItem.customView?.widthAnchor.constraint(equalToConstant: 50),
      let height = barItem.customView?.heightAnchor.constraint(equalToConstant: 22) {
      width.isActive = true
      height.isActive = true
    }
    
    navigationItem.leftBarButtonItem = barItem
  }
  
  func postMenuTapped() {
    NotificationCenter.default.post(name: .menuTapped, object: nil)
  }
  
//  @objc func handleBugerButtonTap() {
//    postMenuTapped()
//  }
  
//  func addTarget(_ btn: UIButton) {
//    button.addTarget(self, action: #selector(handleBugerButtonTap), for: .touchUpInside)
//  }
}


