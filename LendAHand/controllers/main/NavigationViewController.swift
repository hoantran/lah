//
//  NavigationViewController.swift
//  LendAHand
//
//  Created by Hoan Tran on 11/1/17.
//  Copyright © 2017 Hoan Tran. All rights reserved.
//

import UIKit

class NavigationViewController: UINavigationController {
  var observer: NSObjectProtocol?
  
  fileprivate func addObservers() {
    let center = NotificationCenter.default
    let mainQueue = OperationQueue.main
    
    self.observer = center.addObserver(forName: .workersSelected, object: nil, queue: mainQueue) { _ in
      let controller = WorkerViewController()
      self.setViewControllers([controller], animated: true)
    }
    
    self.observer = center.addObserver(forName: .projectsSelected, object: nil, queue: mainQueue) { _ in
      let controller = ProjectViewController()
      self.setViewControllers([controller], animated: true)
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    navigationBar.barTintColor = Constants.color.base
    let controller = WorkerViewController()
//    let controller = ProjectViewController()
    self.setViewControllers([controller], animated: true)
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    addObservers()
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(true)
    if let observer = self.observer {
      NotificationCenter.default.removeObserver(observer)
    }
  }
}
