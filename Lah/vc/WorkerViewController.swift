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
    var tableViewDelegate: WorkerTableViewDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableViewDataSource = WorkerDataSource(tableView: self.tableView)
        self.tableViewDelegate = WorkerTableViewDelegate(tableView: self.tableView, vc: self)
        self.tableView.delegate = self.tableViewDelegate
    }
    
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.post(Notification(name: .getWorkers, object: self, userInfo: nil))
    }
    
    @IBAction func menuTapped(_ sender: UIBarButtonItem) {
        print("menu tapped: worker")
    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "TimeCard" {
//            let upcoming: TimeCardViewController = (( segue.destination ) as! UINavigationController).topViewController as! TimeCardViewController
            let upcoming: TimeCardViewController = segue.destination as! TimeCardViewController
            let indexPath = self.tableView.indexPathForSelectedRow
            let worker = self.tableViewDataSource?.get(atIndex: (indexPath?.row)!)
            upcoming.worker = worker
            self.tableView.deselectRow(at: indexPath!, animated: true)
        }
    }

}
