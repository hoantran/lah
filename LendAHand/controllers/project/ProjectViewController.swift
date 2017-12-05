//
//  ProjectViewController.swift
//  LendAHand
//
//  Created by Hoan Tran on 10/30/17.
//  Copyright © 2017 Hoan Tran. All rights reserved.
//

import UIKit

protocol ProjectControllerDelegate {
  func projectSelected(_ id: String)
}


class ProjectViewController: UITableViewController {
  static let cellID = "cellID"
  var projects: LocalCollection<Project>!
  var sortedProjectIndexes = Array<Int>()
  var projectControllerDelegate: ProjectControllerDelegate?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.register(UITableViewCell.self, forCellReuseIdentifier: ProjectViewController.cellID)
    navigationItem.title = "Projects"
    
    setupAddNewProject()
    setupProjectObservation()
    self.projects.listen()
    print("PRJ--- INIT ---")
  }
  
  deinit {
    self.projects.stopListening()
    print("PRJ--- DEINIT ---")
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    if projectControllerDelegate == nil {
      setupBurgerButton()
    }else {
      self.navigationController?.navigationBar.prefersLargeTitles = false
    }
  }
  
}





