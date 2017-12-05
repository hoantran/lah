//
//  WorkerDataSource.swift
//  LendAHand
//
//  Created by Hoan Tran on 12/5/17.
//  Copyright © 2017 Hoan Tran. All rights reserved.
//

import UIKit

extension WorkerViewController {
  
  override func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.workers.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    if isHighlightedRow(indexPath.row) {
      let cell = tableView.dequeueReusableCell(withIdentifier: HighlightedWorkerCell.cellID, for: indexPath) as! HighlightedWorkerCell
      let indexRow = self.indexOrder[indexPath.row]
      let worker = self.workers[indexRow]
      if let current = getWorkerInCurrents(self.workers.id(indexRow)) {
        cell.start = current.start
        cell.rate = current.rate
        cell.clock.restartAnimation()
        cell.update()
        let contactID = worker.contact
        ContactMgr.shared.fetchName(contactID) { name in
          if let name = name {
            cell.name = name
          } else {
            cell.name = "Can not get name"
          }
        }
      } else {
        print ("Err: Can not find the user's ID in currently highlighted list.")
      }
      
      return cell
      
    } else {
      
      let cell = tableView.dequeueReusableCell(withIdentifier: WorkerViewController.cellID, for: indexPath)
      let indexRow = self.indexOrder[indexPath.row]
      cell.backgroundColor = UIColor.white
      
      let contactID = self.workers[indexRow].contact
      ContactMgr.shared.fetchName(contactID) { name in
        DispatchQueue.main.async {
          if let name = name {
            cell.textLabel?.text = name
          } else {
            cell.textLabel?.text = "Can not get name"
          }
        }
      }
      
      return cell
    }
  }
  
}
