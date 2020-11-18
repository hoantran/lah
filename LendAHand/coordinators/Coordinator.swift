//
//  Coordinator.swift
//  LendAHand
//
//  Created by Hoan Tran on 2/5/19.
//  Copyright © 2019 Hoan Tran. All rights reserved.
//

import UIKit

protocol Coordinator {
  var childCoordinators: [Coordinator] { get set }
  
  init(navigationController:UINavigationController)
  
  func start()
}
