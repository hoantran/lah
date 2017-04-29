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
        let span = billable.end - billable.start;
        let hrs = Int(span/(60 * 60))
        let mins = Int((span - (hrs * 60 * 60))/60)
        
        self.duration.text = "\(hrs)" + "h" + "\(mins)" + "min"
        self.paid.isEnabled = true
        self.time.text = "8AM"
        self.date.text = "Jan 2, 2013"
        self.amount.text = "123.30"
        
    }
    
}
