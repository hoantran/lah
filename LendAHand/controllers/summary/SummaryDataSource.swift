//
//  SummaryDataSource.swift
//  LendAHand
//
//  Created by Hoan Tran on 12/1/17.
//  Copyright © 2017 Hoan Tran. All rights reserved.
//

import UIKit

extension SummaryViewController: UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.collapsibles.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: SummaryCell.cellID, for: indexPath) as! SummaryCell
    let summary = collapsibles[indexPath.row]
    
    cell.amount = summary.amount.roundedTo(places: 2)
    
    let seconds = summary.duration
    let hrs = Int(seconds/(60 * 60))
    let mins = Int((seconds - (hrs * 60 * 60))/60)
    cell.duration = String(format: "%d h %02d", hrs, mins)
    
    
    if let contactID = getContact(summary.works[0].worker) {
      ContactMgr.shared.fetchName(contactID) { name in
        if let name = name {
          cell.textLabel?.text = name
        } else {
          cell.textLabel?.text = "Can not get name"
        }
      }
    }
    return cell
  }
  
//  fileprivate func getContact(_ row: Int)->String? {
//    if let workerID = self.works?[row].worker {
//      if let worker = self.workers?.retrieve(workerID) {
//        return worker.contact
//      }
//    }
//
//    return nil
//  }
  fileprivate func getContact(_ workerID: String)->String? {
    if let worker = self.workers?.retrieve(workerID) {
      return worker.contact
    }
    return nil
  }
  
  func sort(){
    collapsibles.removeAll()
    collapsibles = Array<WorkCollapsible>()
    
    if let works = self.works {
      for k in 0..<works.count {
        let work = works[k]
        if let index = collapsibles.index(where: { collapsible in
          return collapsible.workerID == work.worker
        }) {
          collapsibles[index].add(work)
        } else {
          collapsibles.append(WorkCollapsible(work))
        }
      }
    }
  }
}
