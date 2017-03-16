//
//  WorkerTableViewDelegate.swift
//  Lah
//
//  Created by Hoan Tran on 3/15/17.
//  Copyright © 2017 Pego Consulting. All rights reserved.
//

import UIKit

class WorkerTableViewDelegate:NSObject {
    weak var vc: UIViewController?
    
    init(tableView: UITableView, vc: UIViewController) {
        super.init()
        tableView.delegate = self
        self.vc = vc
    }
}

extension WorkerTableViewDelegate: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("row selected: \(indexPath.row)")
        self.vc?.performSegue(withIdentifier: "TimeCard", sender: self.vc)
    }
}
