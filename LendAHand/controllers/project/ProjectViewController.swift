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


class ProjectViewController: UIViewController {
  static let cellID = "cellID"
  var projects: LocalCollection<Project>!
  var sortedProjectIndexes = Array<Int>()
  var projectControllerDelegate: ProjectControllerDelegate?
  
  lazy var tableView: UITableView = {
    let table = UITableView()
    table.translatesAutoresizingMaskIntoConstraints = false
    table.dataSource = self
    table.delegate = self
    return table
  }()
  
  var emptyView: EmptyScreenView = {
    let v = EmptyScreenView()
    v.translatesAutoresizingMaskIntoConstraints = false
    v.message = "Tap + to add\nyour first project"
    return v
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.view.backgroundColor = Constants.color.bkg
    
    tableView.register(UITableViewCell.self, forCellReuseIdentifier: ProjectViewController.cellID)
    self.title = "Projects"

    setupEmptyScreen()
    setupTableView()
    setupAddNewProject()
    setupProjectObservation()
    self.projects.listen()
  }
  
  deinit {
    self.projects.stopListening()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    if projectControllerDelegate == nil {
      setupBurgerButton()
    }else {
      self.navigationController?.navigationBar.prefersLargeTitles = false
    }
    checkEmptyViewVisibility()
  }
  
  private func setupTableView() {
    view.addSubview(tableView)
    NSLayoutConstraint.activate([
      tableView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
      tableView.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
      tableView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor),
      tableView.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor),
      ])
  }
  
  private func setupEmptyScreen() {
    view.addSubview(emptyView)
    NSLayoutConstraint.activate([
      emptyView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
      emptyView.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
      emptyView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor),
      emptyView.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor),
      ])
  }
  
  func checkEmptyViewVisibility() {
    if self.projects != nil {
      DispatchQueue.main.async {
        self.emptyView.isHidden = self.projects.count > 0
        self.tableView.isHidden = self.projects.count == 0
      }
    }
  }
  
}





