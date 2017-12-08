//
//  WorkerSwipe.swift
//  LendAHand
//
//  Created by Hoan Tran on 12/5/17.
//  Copyright © 2017 Hoan Tran. All rights reserved.
//

import UIKit

extension WorkerViewController {
  
  fileprivate func deleteAction(forRowAtIndexPath indexPath: IndexPath) -> UIContextualAction {
    let action = UIContextualAction(style: .destructive, title: "Delete") { [unowned self] (contextAction: UIContextualAction, sourceView: UIView, completionHandler: (Bool)->Void) in
      
      let indexRow = self.indexOrder[indexPath.row]
      
      let contactID = self.workers[indexRow].contact
      ContactMgr.shared.fetchName(contactID) { name in
          if let name = name {
            print("[-- \(name) --]")
          } else {
            print("[-- Can not get name --]")
          }
      }
      
      if let workerID = self.workers.id(indexRow) {
        if let workerRef = Constants.firestore.collection.workers?.document(workerID) {
          workerRef.delete() { err in
            if let err = err {
              print("Error removing a worker: \(err)")
            } else {
              print("Worker successfully removed!")
            }
          }
        }
        
        if let worksRef = Constants.firestore.collection.works?.whereField(Constants.worker, isEqualTo: workerID) {
          worksRef.limit(to: 200).getDocuments { (docset, error) in
            guard let docset = docset else {
              print("Error: can not get works to be deleted referenced to this worker")
              return
            }
            guard docset.count > 0 else {
              print("Error: No work found to be deleted referenced for this worker")
              return
            }

            let batch = worksRef.firestore.batch()
            docset.documents.forEach { batch.deleteDocument($0.reference) }

            batch.commit { (batchError) in
              if let batchError = batchError {
                print("Error: encountered error when removing works relating to this worker.", batchError)
              } else {
                print("Successfully deleted (max 200) works relating to this worker.")
              }
            }
          }
        }
        
        if let currentID = self.currentID(workerID) {
          if let currentRef = Constants.firestore.collection.currents?.document(currentID) {
            currentRef.delete() { err in
              if let err = err {
                print("Error removing a current: \(err)")
              } else {
                print("Current successfully removed!")
              }
            }
            
          }
        }
        
      }
      
      completionHandler(true)
    }
    
    return action
  }
  
  func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
    let action = deleteAction(forRowAtIndexPath: indexPath )
    return UISwipeActionsConfiguration(actions: [action])
  }
  
}
