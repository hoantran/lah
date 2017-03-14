//
//  WorkerViewController.swift
//  Lah
//
//  Created by Hoan Tran on 2/16/17.
//  Copyright © 2017 Pego Consulting. All rights reserved.
//

import UIKit

class WorkerViewController: UIViewController {
    static let storyboardID = "WorkerVC"
    
    @IBOutlet weak var tableView: UITableView!
    weak var tableViewDataSource: WorkerDataSource?
//    weak var tableViewDelegate: WorkerTableViewDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableViewDataSource = WorkerDataSource(tableView: self.tableView)
//        self.tableViewDelegate = WorkerTableViewDelegate(tableView: self.tableView)
        NotificationCenter.default.post(Notification(name: .getWorkers, object: self, userInfo: nil))
    }
    
    @IBAction func menuTapped(_ sender: UIBarButtonItem) {
        print("menu tapped: worker")
    }


}
