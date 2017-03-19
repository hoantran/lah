//
//  ProjectViewController.swift
//  Lah
//
//  Created by Hoan Tran on 2/16/17.
//  Copyright © 2017 Pego Consulting. All rights reserved.
//

import UIKit

class ProjectViewController: UIViewController, UITableViewDelegate {
    static let storyboardID = "ProjectVC"
    
    @IBOutlet weak var tableView: UITableView!
    weak var tableViewDataSource: ProjectDataSource?
    weak var tableViewDelegate: ProjectTableViewDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableViewDataSource = ProjectDataSource(tableView: self.tableView)
        self.tableViewDelegate = ProjectTableViewDelegate(tableView: self.tableView)
        NotificationCenter.default.post(Notification(name: .getProjects, object: self, userInfo: nil))
    }

    @IBAction func menuTapped(_ sender: UIBarButtonItem) {
        print("menu tapped")
        NotificationCenter.default.post(Notification(name: .menuTapped))
    }
}

