//
//  SummaryEditProject.swift
//  LendAHand
//
//  Created by Hoan Tran on 12/1/17.
//  Copyright © 2017 Hoan Tran. All rights reserved.
//

import UIKit

extension SummaryViewController: CreateUpdateProjectDelegate {
  
  func observeCreateUpdateProject(_ prj: Project) {
    if let projectID = self.projectID {
      Constants.firestore.collection.projects?.document(projectID).updateData([Constants.name: prj.name])
    }
  }
  
  func setupEditProject() {
    let barButton = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(handleEditProject))
    navigationItem.rightBarButtonItem = barButton
  }
  
  @objc fileprivate func handleEditProject() {
    let cancelBtn = UIBarButtonItem(title: "Cancel", style: .plain, target: nil, action: nil)
    navigationItem.backBarButtonItem = cancelBtn
    let controller = CreateUpdateProjectViewController()
    controller.heading = "Edit Project"
    controller.projectDelegate = self
    controller.projectName = self.navigationItem.title
    navigationController?.pushViewController(controller, animated: true)
  }
}
