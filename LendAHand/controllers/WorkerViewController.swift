//
//  WorkerViewController.swift
//  LendAHand
//
//  Created by Hoan Tran on 10/30/17.
//  Copyright © 2017 Hoan Tran. All rights reserved.
//

// http://dennissuratna.com/slide-out-navigation-swift/
// https://www.raywenderlich.com/78568/create-slide-out-navigation-panel-swift

import UIKit

class WorkerViewController: UITableViewController {
  static let cellID = "cellID"
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.register(UITableViewCell.self, forCellReuseIdentifier: WorkerViewController.cellID)
    navigationItem.title = "Workers"
  }
  
  override func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 5
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: WorkerViewController.cellID, for: indexPath)
    
    cell.textLabel?.text = "Worker \(indexPath.row)"
    cell.detailTextLabel?.text = "\(indexPath.row)"
    
    return cell
  }
}
