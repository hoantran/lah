//
//  BillableViewController.swift
//  LendAHand
//
//  Created by Hoan Tran on 11/7/17.
//  Copyright © 2017 Hoan Tran. All rights reserved.
//

import UIKit

class BillableViewController: UIViewController {
  static let cellID = "BillableCellID"
  var worker: Worker?
  var observerToken: NSObjectProtocol?
  
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
      tableView.heightAnchor.constraint(equalTo: view.heightAnchor)
      ])
  }
  
  var work: Work = {
    let project = "0VXsIC8d14Q1x79F3H7y"
    let start = Date()
    let stop = Date(timeInterval: 3723, since: start)
    let w = Work(project: project, rate: 7.8, isPaid: true, start: start, stop: stop, note: "One note to bring")
    return w
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    view.backgroundColor = UIColor.blue
    if let worker = self.worker {
      navigationItem.title = "Can not get name"
      ContactMgr.shared.fetchName(worker.contact) { name in
        if let name = name {
          self.navigationItem.title = name
        }
      }
    }
    
    layoutTable()
    self.tableView.register(BillableCell.self, forCellReuseIdentifier: BillableCell.cellID)
    self.observerToken = NotificationCenter.default.addObserver(forName: .projectChanged, object: nil, queue: nil, using: {notif in
      DispatchQueue.main.async {
        self.tableView.reloadData()
      }
    })
  }
  
  deinit {
    if let token = self.observerToken {
      NotificationCenter.default.removeObserver(token)
    }
  }
}



extension BillableViewController: UITableViewDataSource {
  public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 5
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



