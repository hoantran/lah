//
//  WorkerViewController.swift
//  LendAHand
//
//  Created by Hoan Tran on 10/30/17.
//  Copyright © 2017 Hoan Tran. All rights reserved.
//

import UIKit
import Firebase

class WorkerViewController: UITableViewController {
  var workers: LocalCollection<Worker>!
  var currents: LocalCollection<Current>!
  var indexOrder = Array<Int>()
  var timer: Timer!
  
  static let cellID = "cellID"
  
  var contactAccessPermission = false {
    didSet {
      DispatchQueue.main.async {
        self.sort()
        self.tableView.reloadData()
      }
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    navigationController?.navigationBar.prefersLargeTitles = true
    
    tableView.register(UITableViewCell.self, forCellReuseIdentifier: WorkerViewController.cellID)
    tableView.register(HighlightedWorkerCell.self, forCellReuseIdentifier: HighlightedWorkerCell.cellID)
    navigationItem.title = "Workers"
    setupBurgerButton()
    setupWorkers()
    setupAddNewWorker()
    requestContactAccess()
    setupCurrents()
    
    
    NotificationCenter.default.addObserver(self, selector: #selector(willEnterForeground), name: NSNotification.Name.UIApplicationWillEnterForeground, object: nil)
    
    print("WKR--- INIT ---")
  }
  
  deinit {
    deinitWorkers()
    deinitCurrents()
    NotificationCenter.default.removeObserver(self)
    print("WKR--- DEINIT ---")
  }
  
  @objc private func willEnterForeground() {
    DispatchQueue.main.async {
      self.tableView.reloadData()
    }
  }

  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    startTimer()
    self.tableView.reloadData()
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillAppear(animated)
    clearTimer()
  }
  
  fileprivate func requestContactAccess() {
    ContactMgr.shared.requestContactAccess() { permission in
      self.contactAccessPermission = permission
    }
  }
  
  fileprivate func setupAddNewWorker() {
    let barButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(handleAddNewWorker))
    navigationItem.rightBarButtonItem = barButton
  }
  
  @objc func handleAddNewWorker() {
    let controller = CreateUpdateWorkerViewController()
    controller.workerDelegate = self
    controller.workerDataSourceDelegate = self
    controller.heading = "Create New Worker"
    navigationController?.pushViewController(controller, animated: true)
  }
  
}

