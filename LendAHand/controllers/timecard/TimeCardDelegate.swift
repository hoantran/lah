//
//  TimeCardDelegate.swift
//  LendAHand
//
//  Created by Hoan Tran on 11/13/17.
//  Copyright © 2017 Hoan Tran. All rights reserved.
//

import UIKit

extension TimeCardViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let prevIndexPath = self.selectedIndexPath
    
    if indexPath == self.selectedIndexPath {
      self.selectedIndexPath = nil
    } else {
      self.selectedIndexPath = indexPath
    }
    
    var indexPathArray: Array<IndexPath> = []
    
    if let current = self.selectedIndexPath {
      indexPathArray.append(current)
    }
    if let prev = prevIndexPath {
      indexPathArray.append(prev)
    }
    
    if indexPathArray.count > 0 {
      tableView.reloadRows(at: indexPathArray, with: .automatic)
    }
    
////    tableView.beginUpdates()
////    tableView.endUpdates()
  }
  
  func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    ( cell as! CellObserver).observeChanges()
  }
  
  func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    ( cell as! CellObserver).ignoreChanges()
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    for visible in tableView.visibleCells {
      if let cell = visible as? CellObserver {
        cell.ignoreChanges()
      }
    }
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    if indexPath == self.selectedIndexPath {
      if indexPath.section == TimeCardArrangement.time.rawValue &&
        indexPath.row <= TimeCardArrangement.timeRow.stop.rawValue{
        return TimeCardDatePickerCell.expandedHeight
      }
    }
    
    return TimeCardDatePickerCell.defaultHeight
  }
}
