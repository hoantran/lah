//
//  ProjectViewController.swift
//  Lah
//
//  Created by Hoan Tran on 2/16/17.
//  Copyright © 2017 Pego Consulting. All rights reserved.
//

import UIKit

class ProjectViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    static let storyboardID = "ProjectVC"
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func menuTapped(_ sender: UIBarButtonItem) {
        print("menu tapped")
    }

    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ProjectCell.cellID, for: indexPath) as! ProjectCell
        cell.config("hi")
        return cell
    }

    
}


class ProjectCell: UITableViewCell {
    static let cellID: String = "ProjectCellID"
    
    func config(_ label: String) {
        self.textLabel?.text = label
    }
}
