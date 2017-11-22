//
//  TimeCardViewController.swift
//  LendAHand
//
//  Created by Hoan Tran on 11/13/17.
//  Copyright © 2017 Hoan Tran. All rights reserved.
//

import UIKit

protocol TimeCardDelegate {
  func save(workID: String, work: Work)
}


class TimeCardViewController: UIViewController {
  var selectedIndexPath: IndexPath?
  var workID: String?
  var work: Work? {
    didSet {
//      startMax = work?.stop
//      stopMin = work?.start
//      DispatchQueue.main.async {
//        self.tableView.reloadData()
//      }
    }
  }
  
  var startMax:Date!
  var stopMin:Date!
  
  var observerToken: NSObjectProtocol?
  var timecardDelegate: TimeCardDelegate?
  
  lazy var tableView: UITableView = {
    let table = UITableView(frame: CGRect.zero, style: .grouped)
    table.translatesAutoresizingMaskIntoConstraints = false
    table.separatorColor = table.backgroundColor
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
    tableView.register(TimeCardTitleValueCell.self, forCellReuseIdentifier: TimeCardTitleValueCell.cellID)
    tableView.register(TimeCardNoteCell.self, forCellReuseIdentifier: TimeCardNoteCell.cellID)
    tableView.register(TimeCardPaidCell.self, forCellReuseIdentifier: TimeCardPaidCell.cellID)
    tableView.register(TimeCardProjectCell.self, forCellReuseIdentifier: TimeCardProjectCell.cellID)
    layoutTable()
    setupSaveTimeCard()
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
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    if let work = self.work {
      startMax = work.stop
      stopMin = work.start
    }
    observeProject()
  }
}


extension TimeCardViewController {
  fileprivate func setupSaveTimeCard() {
    let barButton = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(handleSave))
    navigationItem.rightBarButtonItem = barButton
  }
  
  @objc func handleSave() {
    print("save")
    if let workID = self.workID, let work = self.work {
      timecardDelegate?.save(workID: workID, work: work)
    }
    navigationController?.popViewController(animated: true)
  }
}

