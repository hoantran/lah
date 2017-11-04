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

class WorkerViewController: UITableViewController, BurgerButton {
  var workers: LocalCollection<Worker>!
  
  static let cellID = "cellID"
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.register(UITableViewCell.self, forCellReuseIdentifier: WorkerViewController.cellID)
    navigationItem.title = "Workers"
    setupBurgerButton()
    setupWorkerObservation()
    self.workers.listen()
  }
  
  deinit {
    if self.workers != nil {
      self.workers.stopListening()
    }
  }
  
  func setupWorkerObservation() {
    let query = Constants.firestore.collection.workers
    self.workers = LocalCollection(query: query) { [unowned self] (changes) in
      print("..............: Workers")
      changes.forEach(){ print ("[", $0.type, "]", $0) }
      DispatchQueue.main.async {
        self.tableView.reloadData()
      }
    }
  }
  
  
  
  func addTarget(_ btn: UIButton) {
    btn.addTarget(self, action: #selector(handleBugerButtonTap), for: .touchUpInside)
  }
  
  @objc func handleBugerButtonTap() {
    postMenuTapped()
  }
  
  override func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.workers.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: WorkerViewController.cellID, for: indexPath)
    
//    let contactID = self.workers[indexPath.row].contact
    let contactID = "410FE041-5C4E-48DA-B4DE-04C15EA3DBAC"
    cell.textLabel?.text = ContactMgr.shared.fetchName(contactID)
    
    
    return cell
  }
}
