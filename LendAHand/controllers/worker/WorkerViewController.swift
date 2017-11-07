//
//  WorkerViewController.swift
//  LendAHand
//
//  Created by Hoan Tran on 10/30/17.
//  Copyright © 2017 Hoan Tran. All rights reserved.
//

import UIKit

protocol WorkerDataSourceDelegate {
  func exists(_ worker: Worker) -> Bool
}

class WorkerViewController: UITableViewController {
  var workers: LocalCollection<Worker>!
  static let cellID = "cellID"
  var contactAccessPermission = false {
    didSet {
      DispatchQueue.main.async {
        self.tableView.reloadData()
      }
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.register(UITableViewCell.self, forCellReuseIdentifier: WorkerViewController.cellID)
    navigationItem.title = "Workers"
    setupBurgerButton()
    setupWorkerObservation()
    self.workers.listen()
    setupAddNewWorker()
    requestContactAccess()
  }
  
  deinit {
    if self.workers != nil {
      self.workers.stopListening()
    }
  }
  
  fileprivate func requestContactAccess() {
    ContactMgr.shared.requestContactAccess() { permission in
      self.contactAccessPermission = permission
    }
  }
  
  func setupWorkerObservation() {
    let query = Constants.firestore.collection.workers
    self.workers = LocalCollection(query: query) { [unowned self] (changes) in
//      changes.forEach(){ print ("[", $0.type, "]", $0) }
      DispatchQueue.main.async {
        self.tableView.reloadData()
      }
    }
  }
  
  fileprivate func setupAddNewWorker() {
    let barButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(handleAddNewWorker))
    navigationItem.rightBarButtonItem = barButton
  }
  
  @objc func handleAddNewWorker() {
    let cancelBtn = UIBarButtonItem(title: "Cancel", style: .plain, target: nil, action: nil)
    navigationItem.backBarButtonItem = cancelBtn
    let controller = AddNewWorkertViewController()
    controller.workerDelegate = self
    controller.workerDataSourceDelegate = self
    navigationController?.pushViewController(controller, animated: true)
  }
  
  override func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.workers.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: WorkerViewController.cellID, for: indexPath)
    
    let contactID = self.workers[indexPath.row].contact
//    let contactID = "410FE041-5C4E-48DA-B4DE-04C15EA3DBAC"
    cell.textLabel?.text = ContactMgr.shared.fetchName(contactID)
    
    
    return cell
  }
}


extension WorkerViewController:BurgerButton {
  func addTarget(_ btn: UIButton) {
    btn.addTarget(self, action: #selector(handleBugerButtonTap), for: .touchUpInside)
  }
  @objc func handleBugerButtonTap() {
    postMenuTapped()
  }
}

extension WorkerViewController:NewWorkerDelegate {
  func observeNewWorker(_ worker: Worker) {
    Constants.firestore.collection.workers.addDocument(data: worker.dictionary)
  }
}


extension WorkerViewController: WorkerDataSourceDelegate {
  func exists(_ worker: Worker) -> Bool {
    if self.workers.count > 0 {
      for i in 0...self.workers.count-1 {
        if worker == self.workers[i] {
          return true
        }
      }
    }
    return false
  }
}

