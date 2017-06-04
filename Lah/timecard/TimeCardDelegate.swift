//
//  TimeCardDelegate.swift
//  Lah
//
//  Created by Hoan Tran on 5/30/17.
//  Copyright © 2017 Pego Consulting. All rights reserved.
//

import UIKit

class TimeCardDelegate: NSObject {
    weak var vc: UIViewController?
    var selectedIndexPath: IndexPath?
    
    init(tableView: UITableView, vc: UIViewController) {
        super.init()
        tableView.delegate = self
        self.vc = vc
    }
}

extension TimeCardDelegate: UITableViewDelegate {
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
//        if indexPath.section == 0 {
//            return nil
//        }
        
        return indexPath
    }
    
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
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        ( cell as! CellObserver).observeChanges()
    }
    
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        ( cell as! CellObserver).ignoreChanges()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath == self.selectedIndexPath {
            if indexPath.section == 1 {
                return TCDatePickerCell.expandedHeight
            }
        }
        
        return TCDatePickerCell.defaultHeight
    }
}
