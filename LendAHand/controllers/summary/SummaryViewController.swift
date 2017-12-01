//
//  SummaryViewController.swift
//  LendAHand
//
//  Created by Hoan Tran on 11/30/17.
//  Copyright © 2017 Hoan Tran. All rights reserved.
//

import UIKit
import FirebaseFirestore

class SummaryViewController: UIViewController {
  var project: LocalCollection<Project>?
  var works: LocalCollection<Work>?
  

  deinit {
    self.project?.stopListening()
    self.works?.stopListening()
  }
  
  var projectID: String? {
    didSet {
      if let id = self.projectID {
        setupProjectObservation(id)
        setupWorksObservation(id)
      }
    }
  }
  
  fileprivate func setupProjectObservation(_ projectID: String) {
    if  self.project == nil,
      let query = Constants.firestore.collection.projects?.whereField(FieldPath.documentID(), isEqualTo: projectID)
    {
      self.project = LocalCollection(query: query) { [unowned self] (changes) in
        if let name = self.project?[0].name {
          DispatchQueue.main.async {
            self.navigationItem.title = name
          }
        }
      }
      self.project?.listen()
    }
  }
  
  fileprivate func setupWorksObservation(_ projectID: String) {
    if  self.works == nil,
      let query = Constants.firestore.collection.works?.whereField(Constants.project, isEqualTo: projectID)
    {
      self.works = LocalCollection(query: query) { [unowned self] (changes) in
        DispatchQueue.main.async {
          self.tableView.reloadData()
        }
      }
      self.works?.listen()
    }
  }
  
  lazy var tableView: UITableView = {
    let table = UITableView()
    table.translatesAutoresizingMaskIntoConstraints = false
    table.dataSource = self
    table.delegate = self
    return table
  }()
  
  fileprivate func setupTable() {
    layoutTable()
    tableView.register(SummaryCell.self, forCellReuseIdentifier: SummaryCell.cellID)
  }
  
  fileprivate func layoutTable() {
    view.addSubview(tableView)
    NSLayoutConstraint.activate([
      tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      tableView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
      tableView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor),
      tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
      ])
  }
    
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = UIColor.cyan
    
    setupEditProject()
    setupTable()
  }

}
