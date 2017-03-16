//
//  WorkerDataSource.swift
//  Lah
//
//  Created by Hoan Tran on 3/14/17.
//  Copyright © 2017 Pego Consulting. All rights reserved.
//

import UIKit

class WorkerDataSource: NSObject {
    var dataSet: [Worker] {
        didSet {
            self.tableView.reloadData()
        }
    }
    let tableView: UITableView
    
    
    
    init(tableView: UITableView) {
        self.tableView = tableView
        self.dataSet = [Worker]()
        super.init()
        tableView.dataSource = self
        NotificationCenter.default.addObserver(forName: .newWorker, object: nil, queue: nil, using: {notif in
            guard let prj = notif.userInfo?.first?.value as? Worker else { return }
            self.add(prj)
        })
        NotificationCenter.default.addObserver(forName: .delWorkerSvr, object: nil, queue: nil, using: {notif in
            guard let prj = notif.userInfo?.first?.value as? Worker else { return }
            guard let index = self.find(prj) else { return }
            print("deleting index: \(index)")
            self.dataSet.remove(at: index)
            self.tableView.reloadData()
        })
        NotificationCenter.default.addObserver(forName: .getWorkers, object: nil, queue: nil) { _ in
            self.dataSet.removeAll()
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    func get(atIndex: Int) -> Worker? {
        if atIndex < 0 || atIndex > self.dataSet.count - 1 {
            return nil
        } else {
            return self.dataSet[atIndex]
        }
    }
    
    func find(_ prj: Worker) -> Int? {
        if self.dataSet.count > 0 {
            for index in 0...self.dataSet.count-1 {
                if self.dataSet[index] == prj {
                    return index
                }
            }
        }
        return nil
    }
    
    func doesContain(_ item: Worker) -> Bool {
        for p in self.dataSet {
            if p == item {
                return true
            }
        }
        return false
    }
    
    func add(_ item: Worker) {
        if let index = self.find(item) {
            self.dataSet.remove(at: index)
        }
        self.dataSet.append(item)
    }
}

extension WorkerDataSource: UITableViewDataSource {
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataSet.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: WorkerCell.cellID, for: indexPath) as! WorkerCell
        cell.config(self.dataSet[indexPath.row].firstName)
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let toDelete = self.dataSet[indexPath.row]
            self.dataSet.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            NotificationCenter.default.post(Notification(name: .delWorker, object: self, userInfo: ["delWorker":toDelete as Any]))
        }
        
    }
}


class WorkerCell: UITableViewCell {
    static let cellID: String = "WorkerCellID"
    
    func config(_ label: String) {
        self.textLabel?.text = label
    }
}
