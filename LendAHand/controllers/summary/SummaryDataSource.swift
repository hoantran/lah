//
//  SummaryDataSource.swift
//  LendAHand
//
//  Created by Hoan Tran on 12/1/17.
//  Copyright © 2017 Hoan Tran. All rights reserved.
//

import UIKit
//import Reusable

struct Section {
  let id: String
  let cells: [String]
  var isOpen = false
  
  init(id: String, cells: [String]) {
    self.id = id
    self.cells = cells
  }
}


extension SummaryViewController: UITableViewDataSource {
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return collapsibles.count
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return collapsibles[section].isOpen ? collapsibles[section].works.count : 0
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: SummaryCell.cellID, for: indexPath) as! SummaryCell
    let work = collapsibles[indexPath.section].works[indexPath.row]

    cell.amount = work.payable(true)
    cell.duration = work.durationCompact()
    cell.isPaid = work.isPaid

    return cell
  }
  
  func sort(){
    collapsibles.removeAll()
    collapsibles = Array<WorkCollapsible>()
    
    if let works = self.works {
      for k in 0..<works.count {
        let work = works[k]
        if let workID = works.id(k) {
          if let index = collapsibles.index(where: { collapsible in
            return collapsible.workerID == work.worker
          }) {
            collapsibles[index].add(workID: workID, work: work)
          } else {
            collapsibles.append(WorkCollapsible(workID: workID, work: work))
          }
        }
      }
    }
  }
  
  
}
