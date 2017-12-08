//
//  ProjectTableViewDelegate.swift
//  LendAHand
//
//  Created by Hoan Tran on 11/30/17.
//  Copyright © 2017 Hoan Tran. All rights reserved.
//

import UIKit

extension ProjectViewController: UITableViewDelegate {
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 48
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    if let id = self.projects.id(sortedProjectIndexes[indexPath.row]) {
      
      if let delegate = projectControllerDelegate {
        delegate.projectSelected(id)
        self.navigationController?.popViewController(animated: true)
      
      } else {
        let controller = SummaryViewController()
        controller.projectID = id
        navigationController?.pushViewController(controller, animated: true)
      }
      
    }
  }
}
