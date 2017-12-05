//
//  SummaryDelegate.swift
//  LendAHand
//
//  Created by Hoan Tran on 12/1/17.
//  Copyright © 2017 Hoan Tran. All rights reserved.
//

import UIKit

extension SummaryViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 35
  }
  
  func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: SummaryHeaderView.headerID) as? SummaryHeaderView
    
    let summary = collapsibles[section]

    header?.amount = summary.amount.roundedTo(places: 2)

    let seconds = summary.duration
    let hrs = Int(seconds/(60 * 60))
    let mins = Int((seconds - (hrs * 60 * 60))/60)
    header?.duration = String(format: "%d h %02d", hrs, mins)

    if let contactID = getContact(summary.works[0].worker) {
      ContactMgr.shared.fetchName(contactID) { name in
        if let name = name {
          header?.worker = name
        } else {
          header?.worker = "Can not get name"
        }
      }
    }
    
    header?.section = section
    
//    header?.tapHandler = tapHandler // <--- this causes mem leak
    
    header?.tapHandler = { [unowned self] (section) in
      var indexPaths = [IndexPath]()
      for row in self.collapsibles[section].works.indices {
        let indexPath = IndexPath(row: row, section: section)
        indexPaths.append(indexPath)
      }
      
      let isOpen = self.collapsibles[section].isOpen
      self.collapsibles[section].isOpen = !isOpen
      
      if isOpen {
        tableView.deleteRows(at: indexPaths, with: .fade)
      } else {
        tableView.insertRows(at: indexPaths, with: .fade)
      }

    }
    
    
    return header
  }
  
  fileprivate func getContact(_ workerID: String)->String? {
    if let worker = self.workers?.retrieve(workerID) {
      return worker.contact
    }
    return nil
  }
  
  
  func tapHandler(_ section: Int)->Void {
    var indexPaths = [IndexPath]()
    for row in collapsibles[section].works.indices {
      let indexPath = IndexPath(row: row, section: section)
      indexPaths.append(indexPath)
    }
    
    let isOpen = collapsibles[section].isOpen
    collapsibles[section].isOpen = !isOpen
    
    if isOpen {
      tableView.deleteRows(at: indexPaths, with: .fade)
    } else {
      tableView.insertRows(at: indexPaths, with: .fade)
    }
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let work = collapsibles[indexPath.section].works[indexPath.row]
    let workID = collapsibles[indexPath.section].workIDs[indexPath.row]
    let controller = TimeCardViewController()
    
    controller.work = work
    controller.workID = workID
    
    let cancelBtn = UIBarButtonItem(title: "Cancel", style: .plain, target: nil, action: nil)
    self.navigationItem.backBarButtonItem = cancelBtn
    
    controller.timecardDelegate = self
    self.navigationController?.pushViewController(controller, animated: true)
  }
  
  func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    return 35
  }
  
  func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
    return CGFloat.leastNormalMagnitude
  }
  
  func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
    return nil
  }
}

extension SummaryViewController: TimeCardDelegate {}

