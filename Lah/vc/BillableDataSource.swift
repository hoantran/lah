//
//  BillableDataSource.swift
//  Lah
//
//  Created by Hoan Tran on 4/28/17.
//  Copyright © 2017 Pego Consulting. All rights reserved.
//
import UIKit

class BillableDataSource: NSObject {
    let tableView: UITableView
    
    var billables: [Billable] = []

    
    init(tableView: UITableView, workerKey: String){
        self.tableView = tableView
        super.init()
        self.tableView.dataSource = self
        createFakeBillables(workerKey: workerKey)
    }
    
    func createFakeBillables(workerKey: String) {
        let date = Date()
        
        let time = Int(date.timeIntervalSince1970)
        let backtrack = 3 * 30 * 24 * 60 * 60 // about 3 months
        let maxDuration = 24 * 60 * 60 // 1 day
        for _ in 0...9 {
            let start = Int.random(min: (time-backtrack), max: time)
            let end = time + Int.random(min: 3600, max: maxDuration)
            self.billables.append(Billable(rate: Float.random(min: 9.50, max: 15.87),
                                           start: start,
                                           end: end,
                                           project: "-Kf_n1c1uH3Jf0abIdku",
                                           worker: workerKey,
                                           paid: end + 120,
                                           note: "Hella job!" ))
        }
        
        print(self.billables)
    }

    
}


extension BillableDataSource: UITableViewDataSource {

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.billables.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = Bundle.main.loadNibNamed("BillableCell", owner: self, options: nil)?.first as! BillableCellTableViewCell
        cell.config(billable: self.billables[indexPath.row])
        return cell
    }

}
