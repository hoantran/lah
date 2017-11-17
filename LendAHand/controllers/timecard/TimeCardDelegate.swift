//
//  TimeCardDelegate.swift
//  LendAHand
//
//  Created by Hoan Tran on 11/13/17.
//  Copyright © 2017 Hoan Tran. All rights reserved.
//

// there are at least two ways to implement exapanding (UIDatePicker) cell:
// [1] by inserting just a brand new cell that only embeds a UIDatePicker when a row is selected.
//     this is well illustrated here: https://digitalleaves.com/blog/2017/01/dynamic-uidatepickers-in-a-table-view/
//     and here: https://www.appcoda.com/expandable-table-view/
// [2] by expanding a cell that has both the label field(s) and a UIDatePicker just below it/them
//     and when this cell is clicked, the height of the cell changes to expose or cover up the date picker element.
//     this is what is used in this code

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
