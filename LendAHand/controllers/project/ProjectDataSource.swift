//
//  ProjectDataSource.swift
//  LendAHand
//
//  Created by Hoan Tran on 11/30/17.
//  Copyright © 2017 Hoan Tran. All rights reserved.
//

import UIKit

extension ProjectViewController: UITableViewDataSource {
  
  func setupProjectObservation() {
    if let query = Constants.firestore.collection.projects {
      self.projects = LocalCollection(query: query) { [unowned self] (changes) in
        self.sort()
        DispatchQueue.main.async {
          self.tableView.reloadData()
        }
        self.checkEmptyViewVisibility()
      }
    }
  }
  
  private func sort() {
    sortedProjectIndexes.removeAll()
    
    if let sorted = self.projects.sorted(by: { prj1Index, prj2Index in
      return self.projects[prj1Index].name < self.projects[prj2Index].name
    }) {
      self.sortedProjectIndexes = sorted
    }
  }
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.sortedProjectIndexes.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: ProjectViewController.cellID, for: indexPath)
    cell.textLabel?.font = UIFont.systemFont(ofSize: 20, weight: .medium)
    cell.textLabel?.text = self.projects[sortedProjectIndexes[indexPath.row]].name 
    return cell
  }
  
}
