//
//  WorkerViewController.swift
//  LendAHand
//
//  Created by Hoan Tran on 10/30/17.
//  Copyright © 2017 Hoan Tran. All rights reserved.
//

import UIKit
import Firebase

protocol WorkerDataSourceDelegate: class {
  func exists(_ worker: Worker) -> Bool
}

class WorkerViewController: UITableViewController {
  var workers: LocalCollection<Worker>!
  var currents: LocalCollection<Current>!
  var indexOrder = Array<Int>()
  var timer: Timer!

  
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
    tableView.register(HighlightedWorkerCell.self, forCellReuseIdentifier: HighlightedWorkerCell.cellID)
    navigationItem.title = "Workers"
    setupBurgerButton()
    setupWorkers()
    setupAddNewWorker()
    requestContactAccess()
    setupCurrents()
//    print("--- INIT ---")
  }
  
  deinit {
    deinitWorkers()
    deinitCurrents()
//    print("--- DEINIT ---")
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
    if isHighlightedRow(indexPath.row) {
      let cell = tableView.dequeueReusableCell(withIdentifier: HighlightedWorkerCell.cellID, for: indexPath) as! HighlightedWorkerCell
      cell.start = self.currents[indexPath.row].start
      let indexRow = self.indexOrder[indexPath.row]
      cell.rate = self.workers[indexRow].rate
      cell.clock.restartAnimation()
      cell.update()
      let contactID = self.workers[indexRow].contact
      ContactMgr.shared.fetchName(contactID) { name in
        if let name = name {
          cell.name = name
        } else {
          cell.name = "Can not get name"
        }
      }

      return cell
      
    } else {
      
      let cell = tableView.dequeueReusableCell(withIdentifier: WorkerViewController.cellID, for: indexPath)
      let indexRow = self.indexOrder[indexPath.row]
      cell.backgroundColor = UIColor.white

      let contactID = self.workers[indexRow].contact
      ContactMgr.shared.fetchName(contactID) { name in
        if let name = name {
          cell.textLabel?.text = name
        } else {
          cell.textLabel?.text = "Can not get name"
        }
      }
      
      return cell
    }
  }
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let indexRow = self.indexOrder[indexPath.row]

    let controller = BillableViewController()
    controller.worker = self.workers[indexRow]
    controller.workerID = self.workers.id(indexRow)
    navigationController?.pushViewController(controller, animated: true)
    
//    let controller = DummyVC()
//    navigationController?.pushViewController(controller, animated: true)
  }
  
  override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    if isHighlightedRow(indexPath.row) {
      return 70
    } else {
      return 35
    }
  }
}



extension WorkerViewController {
  func startTimer() {
    clearTimer()
    self.timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(timerFired), userInfo: nil, repeats: true)
  }
  
  func clearTimer() {
    self.timer?.invalidate()
    self.timer = nil
  }
  
  @objc func timerFired(timer: Timer) {
    NotificationCenter.default.post(name: .timerForWorkerFired, object: nil)
  }
}



extension WorkerViewController {
  
  func sort() {
    var allCounts: [Int] = Array(repeating:0, count: self.workers.count)
    for (i, _) in allCounts.enumerated() {
      allCounts[i] = i
    }
    
    var newHightlighted = [Int]()
    let newNormals = allCounts.filter { el in
      if let workerID = self.workers.id(el) {
        if isInCurrents(workerID) {
          newHightlighted.append(el)
          return false
        }
      }
      return true
    }
    
    self.indexOrder = newHightlighted + newNormals
  }
  
  func isHighlightedRow(_ row: Int)->Bool {
    return row < self.currents.count
  }
  
  func setupCurrents() {
    let query = Constants.firestore.collection.currents
    self.currents = LocalCollection(query: query) { [unowned self] (changes) in
      self.sort()
      DispatchQueue.main.async {
        self.tableView.reloadData()
      }
    }
    self.currents.listen()
  }

  func deinitCurrents() {
    if self.currents != nil {
      self.currents.stopListening()
    }
  }
  
  func isInCurrents(_ id: String)->Bool {
    if self.currents.count > 0 {
      for i in 0...self.currents.count-1 {
        if id == self.currents[i].worker {
          return true
        }
      }
    }
    return false
  }
}







extension WorkerViewController {
  func setupWorkers() {
    let query = Constants.firestore.collection.workers
    self.workers = LocalCollection(query: query) { [unowned self] (changes) in
      self.sort()
      DispatchQueue.main.async {
        self.tableView.reloadData()
      }
    }
    self.workers.listen()
  }
  
  func deinitWorkers() {
    if self.workers != nil {
      self.workers.stopListening()
    }
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

