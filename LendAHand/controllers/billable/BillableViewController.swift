//
//  BillableViewController.swift
//  LendAHand
//
//  Created by Hoan Tran on 11/7/17.
//  Copyright © 2017 Hoan Tran. All rights reserved.
//

import UIKit

class BillableViewController: UIViewController {
  var currents: LocalCollection<Current>!
  var works: LocalCollection<Work>!
  var timer: Timer!
  
  static let cellID = "BillableCellID"
  var worker: Worker?
  var workerID: String?
  var observerToken: NSObjectProtocol?
  
  lazy var control: ClockControlView = {
    let v = ClockControlView()
    v.translatesAutoresizingMaskIntoConstraints = false
    v.delegate = self
    return v
  }()
  
  lazy var tableView: UITableView = {
    let table = UITableView()
    table.translatesAutoresizingMaskIntoConstraints = false
    table.dataSource = self
    table.delegate = self
    return table
  }()
  
  fileprivate func layoutTable() {
    view.addSubview(tableView)
    NSLayoutConstraint.activate([
      tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
      tableView.widthAnchor.constraint(equalTo: view.widthAnchor),
      tableView.bottomAnchor.constraint(equalTo: control.topAnchor)
      ])
  }
  
//  var work: Work = {
//    let project = "0VXsIC8d14Q1x79F3H7y"
//    let start = Date()
//    let stop = Date(timeInterval: 3723, since: start)
//    let w = Work(rate: 7.8, isPaid: true, start: start, project: project, stop: stop, note: "One note to bring")
//    return w
//  }()
  
  fileprivate func setupHeader() {
    view.backgroundColor = UIColor.blue
    if let worker = self.worker {
      navigationItem.title = "Can not get name"
      ContactMgr.shared.fetchName(worker.contact) { name in
        if let name = name {
          self.navigationItem.title = name
        }
      }
    }
    
  }
  
  fileprivate func setupControl() {
    view.addSubview(control)
    NSLayoutConstraint.activate([
      control.bottomAnchor.constraint(equalTo: view.bottomAnchor),
      control.leftAnchor.constraint(equalTo: view.leftAnchor),
      control.rightAnchor.constraint(equalTo: view.rightAnchor),
      control.heightAnchor.constraint(equalToConstant: 55)
      ])
  }
  
  fileprivate func setupTable() {
    layoutTable()
    self.tableView.register(BillableCell.self, forCellReuseIdentifier: BillableCell.cellID)
  }
  
  fileprivate func observe() {
    self.observerToken = NotificationCenter.default.addObserver(forName: .projectChanged, object: nil, queue: nil, using: {notif in
      DispatchQueue.main.async {
        self.tableView.reloadData()
      }
    })
  }
  
  fileprivate func unObserve() {
    if let token = self.observerToken {
      NotificationCenter.default.removeObserver(token)
      self.observerToken = nil
    }
  }
  
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    print("viewWillAppear")
    observe()
    updateControl()
    
    // toggling the button's state so that EDIT button is shown in enabled state
    self.navigationItem.rightBarButtonItem?.isEnabled = false
    self.navigationItem.rightBarButtonItem?.isEnabled = true
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    print("viewWillDisappear")
    clearTimer()
    unObserve()
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupHeader()
    setupEditWorker()
    setupControl()
    setupTable()
    setupCurrents()
    setupWorks()
//    print("--- INIT ---")
  }
  
  deinit {
//    print("--- DEINIT ---")
    deinitCurrents()
    deinitWorks()
    self.worker = nil
    self.workerID = nil
    clearTimer()
  }
}

extension BillableViewController {
  func setupWorks() {
    if let workerID = self.workerID,
      let query = Constants.firestore.collection.workers?.document(workerID).collection(Constants.works) {
      
      self.works = LocalCollection(query: query) { [unowned self] (changes) in
        DispatchQueue.main.async {
          self.tableView.reloadData()
        }
      }
      self.works.listen()
      
    }
  }
  
  func deinitWorks() {
    if let works = self.works {
      works.stopListening()
      self.works = nil
    }
  }
}

extension BillableViewController {
  fileprivate func setupEditWorker() {
    let barButton = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(handleEditWorker))
    navigationItem.rightBarButtonItem = barButton
  }
  
  @objc func handleEditWorker() {
    if let workerContactID = self.worker?.contact {
      let cancelBtn = UIBarButtonItem(title: "Cancel", style: .plain, target: nil, action: nil)
      navigationItem.backBarButtonItem = cancelBtn
      let controller = CreateUpdateWorkerViewController()
      controller.workerDelegate = self
      controller.isCreateNewWorker = false
      controller.heading = "Edit Worker"
      controller.initialRate = self.worker?.rate
      ContactMgr.shared.fetch(workerContactID) { contact in
        if let contact = contact {
          controller.contact = contact
        }
      }
      navigationController?.pushViewController(controller, animated: true)
    }
  }
}

extension BillableViewController: WorkerDelegate {
  func observeNewWorker(_ worker: Worker) {
    if let workerID = self.workerID {
      Constants.firestore.collection.workers?.document(workerID).updateData([Constants.rate: worker.rate])
    }
  }
  
  
}






