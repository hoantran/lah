//
//  BillableTableDelegate.swift
//  Lah
//
//  Created by Hoan Tran on 4/28/17.
//  Copyright © 2017 Pego Consulting. All rights reserved.
//

import UIKit

class BillableTableDelegate:NSObject {
    weak var vc: BillableViewController?
    
    init(tableView: UITableView, vc: BillableViewController) {
        super.init()
        tableView.delegate = self
        self.vc = vc
    }
}

extension BillableTableDelegate: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("row selected: \(indexPath.row)")
        self.vc?.selectedRow = indexPath.row
        self.vc?.performSegue(withIdentifier: Segue.showTimeCardDetail.rawValue, sender: self.vc)
    }
}
