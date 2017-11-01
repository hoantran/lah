//
//  ProjectViewController.swift
//  LendAHand
//
//  Created by Hoan Tran on 10/30/17.
//  Copyright © 2017 Hoan Tran. All rights reserved.
//

import UIKit

class ProjectViewController: UITableViewController {
  static let cellID = "cellID"
  
  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.register(UITableViewCell.self, forCellReuseIdentifier: ProjectViewController.cellID)
    navigationItem.title = "Projects"
  }
  
  override func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 5
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: ProjectViewController.cellID, for: indexPath)
    
    cell.textLabel?.text = "Project \(indexPath.row)"
    cell.detailTextLabel?.text = "\(indexPath.row)"
    
    return cell
  }
}
