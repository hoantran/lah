//
//  BillableDelegate.swift
//  LendAHand
//
//  Created by Hoan Tran on 11/21/17.
//  Copyright © 2017 Hoan Tran. All rights reserved.
//

import UIKit

extension BillableViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 48
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let controller = TimeCardViewController()
    
    let sortedIndex = self.orderedIndex[indexPath.row]
    controller.work = self.works[sortedIndex]
    if let workID = self.works.id(sortedIndex) {
      controller.workID = workID
    }
    
    let cancelBtn = UIBarButtonItem(title: "Cancel", style: .plain, target: nil, action: nil)
    self.navigationItem.backBarButtonItem = cancelBtn
    
    controller.timecardDelegate = self
    self.navigationController?.pushViewController(controller, animated: true)
  }
  
}
