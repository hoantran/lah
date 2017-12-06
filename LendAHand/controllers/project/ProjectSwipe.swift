//
//  ProjectSwipe.swift
//  LendAHand
//
//  Created by Hoan Tran on 12/5/17.
//  Copyright © 2017 Hoan Tran. All rights reserved.
//

import UIKit
import Firebase
import FirebaseFirestore

extension ProjectViewController {
  
  fileprivate func deleteAction(forRowAtIndexPath indexPath: IndexPath) -> UIContextualAction {
    let action = UIContextualAction(style: .destructive, title: "Delete") { [unowned self] (contextAction: UIContextualAction, sourceView: UIView, completionHandler: (Bool)->Void) in
      
      let sortedPath = self.sortedProjectIndexes[indexPath.row]
      if let projectID = self.projects.id(sortedPath) {
        
        if let projectRef = Constants.firestore.collection.projects?.document(projectID) {
          projectRef.delete() { err in
            if let err = err {
              print("Error removing a project: \(err)")
            } else {
              print("Project successfully removed!")
            }
          }
        }
        
        if let worksRef = Constants.firestore.collection.works?.whereField(Constants.project, isEqualTo: projectID) {
          
          worksRef.limit(to: 200).getDocuments { (docset, error) in
            guard let docset = docset else {
              print("Error: can not get works to be deleted")
              return
            }
            guard docset.count > 0 else {
              print("Error: No work found to be deleted")
              return
            }
            
            let batch = worksRef.firestore.batch()
            docset.documents.forEach { batch.deleteDocument($0.reference) }
            
            batch.commit { (batchError) in
              if let batchError = batchError {
                print("Error: encountered error when removing works relating to a project.", batchError)
              } else {
                print("Successfully deleted (max 200) works relating to project.")
              }
            }
          }
        }
      }
      
      completionHandler(true)
    }
    
    return action
  }
  
  override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
    let action = deleteAction(forRowAtIndexPath: indexPath )
    return UISwipeActionsConfiguration(actions: [action])
  }
  
}
