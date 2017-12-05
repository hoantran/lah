//
//  BillableSwipe.swift
//  LendAHand
//
//  Created by Hoan Tran on 12/4/17.
//  Copyright © 2017 Hoan Tran. All rights reserved.
//

import UIKit

extension BillableViewController {
  fileprivate func deleteAction(forRowAtIndexPath indexPath: IndexPath) -> UIContextualAction {
    let action = UIContextualAction(style: .destructive, title: "Delete") { [unowned self] (contextAction: UIContextualAction, sourceView: UIView, completionHandler: (Bool)->Void) in
      print("Deleting ...")
      
      if let workID = self.works.id(indexPath.row) {
        if let workRef = Constants.firestore.collection.works?.document(workID) {
          workRef.delete() { err in
            if let err = err {
              print("Error removing document: \(err)")
            } else {
              print("Document successfully removed!")
            }
          }
        }
      }
      
//      let workID = self.collapsibles[indexPath.section].workIDs[indexPath.row]
//      if let workRef = Constants.firestore.collection.works?.document(workID) {
//        workRef.delete() { err in
//          if let err = err {
//            print("Error removing document: \(err)")
//          } else {
//            print("Document successfully removed!")
//          }
//        }
//      }
//
//      self.collapsibles[indexPath.section].works.remove(at: indexPath.row)
//      if self.collapsibles[indexPath.section].works.count > 0 {
//        self.tableView.deleteRows(at: [indexPath], with: .left)
//      } else {
//        self.collapsibles.remove(at: indexPath.section)
//        self.tableView.deleteSections(IndexSet(arrayLiteral: indexPath.section) , with: .fade)
//      }
      completionHandler(true)
    }
    
    return action
  }
  
  func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
    let action = deleteAction(forRowAtIndexPath: indexPath )
    return UISwipeActionsConfiguration(actions: [action])
  }

}
