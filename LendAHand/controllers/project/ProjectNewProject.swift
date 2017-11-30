//
//  ProjectNewProject.swift
//  LendAHand
//
//  Created by Hoan Tran on 11/30/17.
//  Copyright © 2017 Hoan Tran. All rights reserved.
//

import UIKit

extension ProjectViewController {
  func setupAddNewProject() {
    let barButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(handleAddNewProject))
    navigationItem.rightBarButtonItem = barButton
  }
  
  @objc func handleAddNewProject() {
    let cancelBtn = UIBarButtonItem(title: "Cancel", style: .plain, target: nil, action: nil)
    navigationItem.backBarButtonItem = cancelBtn
    let controller = AddNewProjectViewController()
    controller.projectDelegate = self
    navigationController?.pushViewController(controller, animated: true)
  }
}
