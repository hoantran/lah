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
      DispatchQueue.main.async {
//        tableView.reloadRows(at: indexPathArray, with: .automatic)
//        tableView.reloadSections(IndexSet(integer: 1  ), with: .automatic)
//        tableView.reloadData()
      }
    }
    
    var myarray = [IndexPath]()
    for i in 0..<2 {
      myarray.append(IndexPath(item: i, section: 1))
    }
    
//    tableView.beginUpdates()
    if indexPathArray.count > 0 {
//      DispatchQueue.main.async {
                tableView.reloadRows(at: indexPathArray, with: .automatic)
        //        tableView.reloadSections(IndexSet(integer: 1  ), with: .automatic)
        //        tableView.reloadData()
//      }
    }
//    var indexPath = IndexPath(item: 0, section: 1)
//    tableView.reloadRows(at: [indexPath], with: .top)
//    indexPath = IndexPath(item: 1, section: 1)
//    tableView.reloadRows(at: [indexPath], with: .top)
//    tableView.reloadRows(at: myarray, with: .automatic)
//    if let yourarray = tableView.indexPathsForVisibleRows {
//      DispatchQueue.main.async {
//        tableView.reloadRows(at: yourarray, with: .automatic)
//      }
//    }
//    tableView.endUpdates()

    print(".....")
    for path in indexPathArray {
      print(path)
    }
    
    
////    tableView.beginUpdates()
//    if indexPathArray.count > 0 {
//      tableView.reloadRows(at: indexPathArray, with: .automatic)
//    }
////    tableView.endUpdates()
  }
  
  func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    ( cell as! CellObserver).observeChanges()
  }
  
  func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    ( cell as! CellObserver).ignoreChanges()
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
