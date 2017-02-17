//
//  AddProjectTableViewDelegate.swift
//  Lah
//
//  Created by Hoan Tran on 2/17/17.
//  Copyright © 2017 Pego Consulting. All rights reserved.
//

import UIKit

class AddProjectTableViewDelegate:NSObject {
    
    init(tableView: UITableView) {
        super.init()
        tableView.delegate = self
    }
}

extension AddProjectTableViewDelegate: UITableViewDelegate {
}
