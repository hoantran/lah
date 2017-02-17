//
//  ProjectDataSource.swift
//  Lah
//
//  Created by Hoan Tran on 2/17/17.
//  Copyright © 2017 Pego Consulting. All rights reserved.
//

import UIKit

class ProjectDataSource: NSObject {
    
    init(tableView: UITableView) {
        super.init()
        tableView.dataSource = self
    }
}

extension ProjectDataSource: UITableViewDataSource {
    
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
