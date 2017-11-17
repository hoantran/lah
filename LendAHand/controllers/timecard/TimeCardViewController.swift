//
//  TimeCardViewController.swift
//  LendAHand
//
//  Created by Hoan Tran on 11/13/17.
//  Copyright © 2017 Hoan Tran. All rights reserved.
//

import UIKit

class TimeCardViewController: UIViewController {
  var selectedIndexPath: IndexPath?
  var work: Work? {
    didSet {
      if let work = self.work {
        refreshData(work)
      }
    }
  }
  
  var rate:  TimeCardRateCell = {
    let c = TimeCardRateCell()
    c.textLabel?.text = "RATE"
    return c
  }()
  var start: TimeCardDatePickerCell = {
    let c = TimeCardDatePickerCell()
    c.title = "START"
    return c
  }()
  var stop: TimeCardDatePickerCell = {
    let c = TimeCardDatePickerCell()
    c.title = "STOP"
    return c
  }()
  var duration:  TimeCardRateCell = {
    let c = TimeCardRateCell()
    c.textLabel?.text = "DURATION"
    return c
  }()
  var project:  TimeCardRateCell = {
    let c = TimeCardRateCell()
    c.textLabel?.text = "PROJECT"
    return c
  }()
  var paid:  TimeCardRateCell = {
    let c = TimeCardRateCell()
    c.textLabel?.text = "PAID"
    return c
  }()
  var note:  TimeCardRateCell = {
    let c = TimeCardRateCell()
    c.textLabel?.text = "NOTE"
    return c
  }()
  
  lazy var tableView: UITableView = {
    let table = UITableView(frame: CGRect.zero, style: .grouped)
    table.translatesAutoresizingMaskIntoConstraints = false
    table.dataSource = self
    table.delegate = self
    return table
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    navigationItem.title = "Edit Timecard"
    view.backgroundColor = UIColor.brown
    navigationController?.navigationBar.prefersLargeTitles = true
    
    tableView.register(TimeCardDatePickerCell.self, forCellReuseIdentifier: TimeCardDatePickerCell.cellID)
    tableView.register(TimeCardRateCell.self, forCellReuseIdentifier: TimeCardRateCell.cellID)
    layoutTable()
  }
  
  fileprivate func layoutTable() {
    view.addSubview(tableView)
    NSLayoutConstraint.activate([
      tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
      tableView.widthAnchor.constraint(equalTo: view.widthAnchor),
      tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
      ])
  }
  
}
