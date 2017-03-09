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
            self.add(prj)
        })
        NotificationCenter.default.addObserver(forName: .delProjectSvr, object: nil, queue: nil, using: {notif in
            guard let prj = notif.userInfo?.first?.value as? Project else { return }
            guard let index = self.find(prj) else { return }
            print("deleting index: \(index)")
            self.projects.remove(at: index)
            self.tableView.reloadData()
        })
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    func find(_ prj: Project) -> Int? {
        if self.projects.count > 0 {
            for index in 0...self.projects.count-1 {
                if self.projects[index] == prj {
                    return index
                }
            }
        }
        return nil
    }
    
    func doesContain(_ prj: Project) -> Bool {
        for p in self.projects {
            if p == prj {
                return true
            }
        }
        return false
    }
    
    func add(_ prj: Project) {
        if !doesContain(prj) {
            self.projects.append(prj)
            self.tableView.reloadData()
        }
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
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let toDelete = self.projects[indexPath.row]
            self.projects.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            NotificationCenter.default.post(Notification(name: .delProject, object: self, userInfo: ["delProject":toDelete as Any]))
        }

    }
}


class ProjectCell: UITableViewCell {
    static let cellID: String = "ProjectCellID"
    
    func config(_ label: String) {
        self.textLabel?.text = label
    }
}
