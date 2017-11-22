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


class ProjectViewController: UITableViewController, NewProjectDelegate {
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
//    print("--- INIT ---")
  }
  
  deinit {
    self.projects.stopListening()
//    print("--- DEINIT ---")
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    if projectControllerDelegate == nil {
      setupBurgerButton()
    }else {
//      self.navigationController?.navigationItem.largeTitleDisplayMode = .never
      self.navigationController?.navigationBar.prefersLargeTitles = false
    }
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
      self.sort()
      DispatchQueue.main.async {
        self.tableView.reloadData()
      }
    }
  }

  private func sort() {
    if let sorted = self.projects.sorted(by: { prj1Index, prj2Index in
      return self.projects[prj1Index].name < self.projects[prj2Index].name
    }) {
      self.sortedProjectIndexes = sorted
    }
  }
  
  
  override func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.sortedProjectIndexes.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: ProjectViewController.cellID, for: indexPath)
    cell.textLabel?.text = self.projects[sortedProjectIndexes[indexPath.row]].name  //  sortedProjects[indexPath.row].name //  "Project \(indexPath.row)"
    return cell
  }
}

extension ProjectViewController {
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    if let delegate = projectControllerDelegate {
      if let id = self.projects.id(sortedProjectIndexes[indexPath.row]) {
        delegate.projectSelected(id)
      }
      self.navigationController?.popViewController(animated: true)
    }
  }
}

extension ProjectViewController {
  
  func setupBurgerButton() {
    let button = UIButton()
    button.setImage(UIImage(named: "menu.png"), for: .normal)
    addTarget(button)
    let barItem = UIBarButtonItem(customView: button)
    
    if  let width = barItem.customView?.widthAnchor.constraint(equalToConstant: 22),
      let height = barItem.customView?.heightAnchor.constraint(equalToConstant: 22) {
      width.isActive = true
      height.isActive = true
    }
    
    navigationItem.leftBarButtonItem = barItem
  }
  
  func addTarget(_ btn: UIButton) {
    btn.addTarget(self, action: #selector(handleBugerButtonTap), for: .touchUpInside)
  }
  
  @objc func handleBugerButtonTap() {
    postMenuTapped()
  }
  
  func postMenuTapped() {
    NotificationCenter.default.post(name: .menuTapped, object: nil)
  }
}



