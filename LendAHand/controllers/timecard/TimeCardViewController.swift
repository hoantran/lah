//
//  TimeCardViewController.swift
//  LendAHand
//
//  Created by Hoan Tran on 11/13/17.
//  Copyright © 2017 Hoan Tran. All rights reserved.
//

import UIKit

protocol TimeCardDelegate: NSObjectProtocol {
  func save(workID: String, work: Work)
}

extension TimeCardDelegate {
  func save(workID: String, work: Work) {
    Constants.firestore.collection.works?.document(workID).setData(work.dictionary)
  }
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
  var isEditingNote: Bool = false
  
  var startMax:Date!
  var stopMin:Date!
  
  var observerToken: NSObjectProtocol?
  weak var timecardDelegate: TimeCardDelegate?
  
  lazy var tableView: UITableView = {
    let table = UITableView(frame: CGRect.zero, style: .grouped)
    table.translatesAutoresizingMaskIntoConstraints = false
    table.separatorColor = table.backgroundColor
    table.dataSource = self
    table.delegate = self
    table.keyboardDismissMode = .interactive
    return table
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.view.backgroundColor = Constants.color.bkg
    
    navigationItem.title = "Edit Timecard"
    navigationController?.navigationBar.prefersLargeTitles = true
    
    tableView.register(TimeCardDatePickerCell.self, forCellReuseIdentifier: TimeCardDatePickerCell.cellID)
    tableView.register(TimeCardRateCell.self, forCellReuseIdentifier: TimeCardRateCell.cellID)
    tableView.register(TimeCardTitleValueCell.self, forCellReuseIdentifier: TimeCardTitleValueCell.cellID)
    tableView.register(TimeCardNoteCell.self, forCellReuseIdentifier: TimeCardNoteCell.cellID)
    tableView.register(TimeCardPaidCell.self, forCellReuseIdentifier: TimeCardPaidCell.cellID)
    tableView.register(TimeCardProjectCell.self, forCellReuseIdentifier: TimeCardProjectCell.cellID)
    layoutTable()
    setupSaveTimeCard()
    
    let tap = UITapGestureRecognizer(target: self, action: #selector(endEditing))
    tap.cancelsTouchesInView = false
    self.view.addGestureRecognizer(tap)
  }
  
  @objc func keyboardWillShow(notification: NSNotification) {
    print("keyboardWill SHOW")
    if isEditingNote {
      let keyboardFrame = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as AnyObject).cgRectValue
      let keyboardDuration = (notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as AnyObject).doubleValue
      
      let insets = UIEdgeInsets(top: 0, left: 0, bottom: keyboardFrame!.height, right: 0)
      tableView.contentInset = insets
      UIView.animate(withDuration: keyboardDuration!, animations: {
        self.view.layoutIfNeeded()
      })
    }
  }
  
  @objc func keyboardWillHide(_ notification: Notification) {
     print("keyboardWill HIDE")
    let keyboardDuration = (notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as AnyObject).doubleValue
    
    tableView.contentInset = UIEdgeInsets.zero
    UIView.animate(withDuration: keyboardDuration!, animations: {
      self.view.layoutIfNeeded()
    })
  }
  
  fileprivate func layoutTable() {
    view.addSubview(tableView)
    
    NSLayoutConstraint.activate([
      tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
      tableView.widthAnchor.constraint(equalTo: view.widthAnchor),
      tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
      ])
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    if let work = self.work {
      startMax = work.stop
      stopMin = work.start
    }
    observeProject()
    
    // http://kingscocoa.com/tutorials/keyboard-content-offset/
    NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
    NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)

  }
  
}


extension TimeCardViewController {
  fileprivate func setupSaveTimeCard() {
    let barButton = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(handleSave))
    navigationItem.rightBarButtonItem = barButton
  }
  
  @objc func handleSave() {
    if let workID = self.workID, let work = self.work {
      timecardDelegate?.save(workID: workID, work: work)
    }
    navigationController?.popViewController(animated: true)
  }
}


extension TimeCardViewController {
  @objc func endEditing() {
    self.view.endEditing(true)
  }
}

