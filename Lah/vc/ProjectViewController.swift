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
    var tableViewDataSource: ProjectDataSource?
    var tableViewDelegate: ProjectTableViewDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableViewDataSource = ProjectDataSource(tableView: self.tableView)
        self.tableViewDelegate = ProjectTableViewDelegate(tableView: self.tableView)
    }

    @IBAction func menuTapped(_ sender: UIBarButtonItem) {
        print("menu tapped")
    }
}

