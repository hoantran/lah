//
//  ProjectTableViewDelegate.swift
//  LendAHand
//
//  Created by Hoan Tran on 11/30/17.
//  Copyright © 2017 Hoan Tran. All rights reserved.
//

import UIKit

extension ProjectViewController {
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    if let delegate = projectControllerDelegate {
      if let id = self.projects.id(sortedProjectIndexes[indexPath.row]) {
        delegate.projectSelected(id)
      }
      self.navigationController?.popViewController(animated: true)
    }
  }
}
