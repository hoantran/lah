//
//  WorkerViewController.swift
//  LendAHand
//
//  Created by Hoan Tran on 10/30/17.
//  Copyright © 2017 Hoan Tran. All rights reserved.
//

import UIKit
import Firebase
import Crashlytics

class WorkerViewController: UIViewController {
  var workers: LocalCollection<Worker>!
  var currents: LocalCollection<Current>!
  var indexOrder = Array<Int>()
  var timer: Timer!
  
  static let cellID = "cellID"
  
  lazy var tableView: UITableView = {
    let table = UITableView()
    table.translatesAutoresizingMaskIntoConstraints = false
    table.dataSource = self
    table.delegate = self
    return table
  }()
  
  var contactAccessPermission = false {
    didSet {
      self.sort()
      DispatchQueue.main.async {
        self.tableView.reloadData()
      }
      checkEmptyViewVisibility()
    }
  }
  
  var emptyView: EmptyScreenView = {
    let v = EmptyScreenView()
    v.translatesAutoresizingMaskIntoConstraints = false
    v.message = "Tap + to add\nyour first worker"
    return v
  }()
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.view.backgroundColor = Constants.color.bkg
    
    navigationController?.navigationBar.prefersLargeTitles = true

    self.title = "Workers"
    
    tableView.register(UITableViewCell.self, forCellReuseIdentifier: WorkerViewController.cellID)
    tableView.register(HighlightedWorkerCell.self, forCellReuseIdentifier: HighlightedWorkerCell.cellID)
    
    setupEmptyScreen()
    setupTableView()
    setupBurgerButton()
    setupWorkers()
    setupAddNewWorker()
    requestContactAccess()
    setupCurrents()
    
    
    
    NotificationCenter.default.addObserver(self, selector: #selector(willEnterForeground), name: UIApplication.willEnterForegroundNotification, object: nil)
  }
  
  deinit {
    deinitWorkers()
    deinitCurrents()
    NotificationCenter.default.removeObserver(self)
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
    
    checkEmptyViewVisibility()
  }
  
  func checkEmptyViewVisibility() {
    if self.workers != nil {
      DispatchQueue.main.async {
        self.emptyView.isHidden = self.workers.count > 0
        self.tableView.isHidden = self.workers.count == 0
      }
    }
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
  
  private func setupEmptyScreen() {
    view.addSubview(emptyView)
    NSLayoutConstraint.activate([
      emptyView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
      emptyView.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
      emptyView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor),
      emptyView.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor),
      ])
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
  
}

