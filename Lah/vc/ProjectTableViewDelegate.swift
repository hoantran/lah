//
//  ProjectTableViewDelegate.swift
//  Lah
//
//  Created by Hoan Tran on 2/17/17.
//  Copyright © 2017 Pego Consulting. All rights reserved.
//

import UIKit

class ProjectTableViewDelegate:NSObject {
    
    init(tableView: UITableView) {
        super.init()
        tableView.delegate = self
    }
}

extension ProjectTableViewDelegate: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("row selected: \(indexPath.row)")
    }
}
