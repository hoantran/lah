//
//  BillableCellTableViewCell.swift
//  Lah
//
//  Created by Hoan Tran on 4/28/17.
//  Copyright © 2017 Pego Consulting. All rights reserved.
//

import UIKit


class BillableCellTableViewCell: UITableViewCell {
    static let cellID: String = "BillableCellID"
    
    @IBOutlet weak var duration: UILabel!
    @IBOutlet weak var paid: UILabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var amount: UILabel!
    
    func config(billable: Billable) {
        self.duration.text = Billable.getDuration(start: billable.start, end: billable.end)
        self.paid.isEnabled = true
        
        let date = Date(timeIntervalSince1970: TimeInterval(billable.start))
        let dayTimePeriodFormatter = DateFormatter()
        
        dayTimePeriodFormatter.dateFormat = "hh:mm a"
        self.time.text = dayTimePeriodFormatter.string(from: date)
        
        dayTimePeriodFormatter.dateFormat = "MMM dd, YYYY"
        self.date.text = dayTimePeriodFormatter.string(from: date)
        
        self.amount.text = Billable.getTotal(start: billable.start, end: billable.end, rate: billable.rate)
    }
    
}
