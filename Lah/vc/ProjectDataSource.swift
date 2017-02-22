//
//  ProjectDataSource.swift
//  Lah
//
//  Created by Hoan Tran on 2/17/17.
//  Copyright © 2017 Pego Consulting. All rights reserved.
//

import UIKit

class ProjectDataSource: NSObject {
    var projects: [Project]
    let tableView: UITableView
    
    init(tableView: UITableView) {
        self.projects = [Project]()
        self.tableView = tableView
        super.init()
        tableView.dataSource = self
        NotificationCenter.default.addObserver(forName: .newProject, object: nil, queue: nil, using: {notif in
            guard let prj = notif.userInfo?.first?.value as? Project else { return }
            self.projects.append(prj)
            self.tableView.reloadData()
        })
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

extension ProjectDataSource: UITableViewDataSource {
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.projects.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ProjectCell.cellID, for: indexPath) as! ProjectCell
        cell.config(self.projects[indexPath.row].name)
        return cell
    }
}


class ProjectCell: UITableViewCell {
    static let cellID: String = "ProjectCellID"
    
    func config(_ label: String) {
        self.textLabel?.text = label
    }
}
