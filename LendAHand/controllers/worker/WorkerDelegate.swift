//
//  WorkerDelegate.swift
//  LendAHand
//
//  Created by Hoan Tran on 12/5/17.
//  Copyright © 2017 Hoan Tran. All rights reserved.
//

import UIKit

extension WorkerViewController {
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let indexRow = self.indexOrder[indexPath.row]
    
    let controller = BillableViewController()
    controller.worker = self.workers[indexRow]
    controller.workerID = self.workers.id(indexRow)
    navigationController?.pushViewController(controller, animated: true)
  }
  
  override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    if isHighlightedRow(indexPath.row) {
      return 70
    } else {
      return 35
    }
  }
  
}
