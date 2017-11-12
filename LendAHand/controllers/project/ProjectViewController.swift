//
//  ProjectViewController.swift
//  LendAHand
//
//  Created by Hoan Tran on 10/30/17.
//  Copyright © 2017 Hoan Tran. All rights reserved.
//

import UIKit

class ProjectViewController: UITableViewController, BurgerButton, NewProjectDelegate {
  static let cellID = "cellID"
  var projects: LocalCollection<Project>!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.register(UITableViewCell.self, forCellReuseIdentifier: ProjectViewController.cellID)
    navigationItem.title = "Projects"
    
    setupBurgerButton()
    setupAddNewProject()
    
    setupProjectObservation()
    self.projects.listen()
//    print("--- INIT ---")
  }
  
  deinit {
    self.projects.stopListening()
//    print("--- DEINIT ---")
  }
  
  func addTarget(_ btn: UIButton) {
    btn.addTarget(self, action: #selector(handleBugerButtonTap), for: .touchUpInside)
  }
  
  @objc func handleBugerButtonTap() {
    postMenuTapped()
  }
  
  fileprivate func setupAddNewProject() {
    let barButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(handleAddNewProject))
    navigationItem.rightBarButtonItem = barButton
  }
  
  @objc func handleAddNewProject() {
    let cancelBtn = UIBarButtonItem(title: "Cancel", style: .plain, target: nil, action: nil)
    navigationItem.backBarButtonItem = cancelBtn
    let controller = AddNewProjectViewController()
    controller.projectDelegate = self
    navigationController?.pushViewController(controller, animated: true)
  }
  
  func observeNewProject(_ prj: Project) {
    Constants.firestore.collection.projects.addDocument(data: prj.dictionary)
  }
  
  func setupProjectObservation() {
    let query = Constants.firestore.collection.projects
    self.projects = LocalCollection(query: query) { [unowned self] (changes) in
//      changes.forEach(){ print ("[", $0.type, "]", $0) }
      DispatchQueue.main.async {
        self.tableView.reloadData()
      }
    }
  }

  
  override func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.projects.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: ProjectViewController.cellID, for: indexPath)
    
    cell.textLabel?.text = self.projects[indexPath.row].name //  "Project \(indexPath.row)"
//    cell.detailTextLabel?.text = "\(indexPath.row)"
    
    return cell
  }
}
