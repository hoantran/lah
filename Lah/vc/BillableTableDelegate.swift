//
//  BillableTableDelegate.swift
//  Lah
//
//  Created by Hoan Tran on 4/28/17.
//  Copyright © 2017 Pego Consulting. All rights reserved.
//

import UIKit

class BillableTableDelegate:NSObject {
    weak var vc: UIViewController?
    
    init(tableView: UITableView, vc: UIViewController) {
        super.init()
        tableView.delegate = self
        self.vc = vc
    }
}

extension BillableTableDelegate: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("row selected: \(indexPath.row)")
//        self.vc?.performSegue(withIdentifier: "TimeCard", sender: self.vc)
    }
}
