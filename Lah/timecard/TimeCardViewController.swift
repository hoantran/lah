//
//  TimeCardViewController.swift
//  Lah
//
//  Created by Hoan Tran on 5/30/17.
//  Copyright © 2017 Pego Consulting. All rights reserved.
//

import UIKit


protocol CellObserver {
    func observeChanges()
    func ignoreChanges()
}


class TimeCardViewController: UIViewController {
    var bill: Billable?
    @IBOutlet weak var table: UITableView!
    
    var datasource: TimeCardDataSource?
    var tableDelegate: UITableViewDelegate?
    
    var isValidated: Bool {
        // rate
        //        guard let rate = self.rate.text else { return false }
        //        if rate.isEmpty { return false }
        //        if rate.characters.count == 1 && rate.characters.first == "$" { return false }
        //
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.datasource = TimeCardDataSource(tableView: self.table, bill: self.bill)
        self.tableDelegate = TimeCardDelegate(tableView: self.table, vc: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationItem.title = "Edit"
        self.navigationItem.rightBarButtonItem  = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(self.save))
        self.navigationItem.rightBarButtonItem?.isEnabled = self.isValidated

    }
    
    func save() {
        //        if self.rate.text?.characters.count == 0 {
        //            print("nothing")
        //        } else {
        //            if var rate = self.rate.text {
        //                if rate.characters.first == "$" {
        //                    rate.remove(at: rate.startIndex)
        //                }
        //                let newRate = Float(rate)
        //                print("rate \(newRate ?? 0.00)")
        //
        //            } else {
        //                print("no rate")
        //            }
        //        }
        _ = self.navigationController?.popViewController(animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
