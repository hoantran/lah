//
//  BillableViewController.swift
//  LendAHand
//
//  Created by Hoan Tran on 11/7/17.
//  Copyright © 2017 Hoan Tran. All rights reserved.
//

import UIKit

protocol MoreExtension {
  func moreSetups()
  func moreDeinits()
}

extension MoreExtension {
  func moreSetups(){}
  func moreDeinits(){}
}

class BillableViewController: UIViewController, MoreExtension {
  var currents: LocalCollection<Current>!
  
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
    var top:CGFloat = 44
    if let rect = self.navigationController?.navigationBar.frame {
      top = rect.size.height + rect.origin.y
    }
    view.addSubview(tableView)
    NSLayoutConstraint.activate([
      tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: top),
      tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
      tableView.widthAnchor.constraint(equalTo: view.widthAnchor),
      tableView.bottomAnchor.constraint(equalTo: control.topAnchor)
      ])
  }
  
  var work: Work = {
    let project = "0VXsIC8d14Q1x79F3H7y"
    let start = Date()
    let stop = Date(timeInterval: 3723, since: start)
    let w = Work(rate: 7.8, isPaid: true, start: start, project: project, stop: stop, note: "One note to bring")
    return w
  }()
  
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
    updateControl()
  }
  
  fileprivate func setupTable() {
    layoutTable()
    self.tableView.register(BillableCell.self, forCellReuseIdentifier: BillableCell.cellID)
    self.observerToken = NotificationCenter.default.addObserver(forName: .projectChanged, object: nil, queue: nil, using: {notif in
      DispatchQueue.main.async {
        self.tableView.reloadData()
      }
    })
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupHeader()
    setupControl()
    setupTable()
    moreSetups()
  }
  
  deinit {
    if let token = self.observerToken {
      NotificationCenter.default.removeObserver(token)
    }
    moreDeinits()
  }
}



extension BillableViewController: ClockControlDelegate {
  
  func updateControl() {
    if isOnTheClock() {
      control.showClockOut()
    } else {
      control.showClockIn()
    }
  }
  
  func currentIndex()->Int? {
    if let workerID = self.workerID {
      if let currents = self.currents {
        if currents.count > 0 {
          for i in 0...currents.count - 1 {
            if workerID == currents[i].worker {
              return i
            }
          }
        }
      }
    } else {
      print ("Err: workerID is not set")
    }
    return nil
  }
  
  func isOnTheClock()->Bool {
    if currentIndex() == nil {
      return false
    } else {
      return true
    }
  }
  
  func tapped() {
    if isOnTheClock() {
      clockOut()
    } else {
      clockIn()
    }
  }
  
  func clockIn() {
    self.control.showClockOut()
    if let workerID = self.workerID {
      let current = Current(
        worker: workerID,
        start: Date())
      Constants.firestore.collection.currents.addDocument(data: current.dictionary)
    } else {
      print ("Err: workerID is not set")
    }
  }
  
  func clockOut() {
    self.control.showClockIn()
    if let index = currentIndex() {
      if let currentID = self.currents.id(index) {
        let current = self.currents[index]
        //
        Constants.firestore.collection.currents.document(currentID).delete() { err in
          if let err = err {
            print("Err while deleting \(currentID): \(err)")
          }
        }
        
        //
        if let worker = self.worker {
          let work = Work(rate: worker.rate, isPaid: false, start: current.start, project: nil, stop: Date(), note: nil)
          Constants.firestore.collection.workers.document(current.worker).collection(Constants.works).addDocument(data: work.dictionary)
        } else {
          print ("Err: worker is not set; can save this work period")
        }
        
      }
    } else {
      print ("Err: can not index of the current entry")
    }
  }
  
  func moreSetups() {
    let query = Constants.firestore.collection.currents
    self.currents = LocalCollection(query: query) { [unowned self] (changes) in
      //      changes.forEach(){ print ("[", $0.type, "]", $0) }
      self.updateControl()
    }
    self.currents.listen()
  }
  
  func moreDeinits() {
    if let currents = self.currents {
      currents.stopListening()
    }
  }
}



extension BillableViewController: UITableViewDataSource {
  public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 25
  }
  public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: BillableCell.cellID, for: indexPath) as! BillableCell
    cell.work = work
    return cell
  }
}

extension BillableViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 40
  }
}



