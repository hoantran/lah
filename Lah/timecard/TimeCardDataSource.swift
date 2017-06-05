//
//  TimeCardDataSource.swift
//  Lah
//
//  Created by Hoan Tran on 5/30/17.
//  Copyright © 2017 Pego Consulting. All rights reserved.
//

import UIKit

class TimeCardDataSource: NSObject {
    let tableView: UITableView
    let bill: Billable?
    
    init(tableView: UITableView, bill: Billable?) {
        self.tableView = tableView
        self.bill = bill
        super.init()
        self.tableView.dataSource = self
    }
}

extension TimeCardDataSource: UITableViewDataSource {

    public func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return 3
        }
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "rateCell", for: indexPath) as! TCRateCell
            cell.rate.delegate = cell.rateDelegate
            if let bill = self.bill {
                cell.rate.text = "$\(bill.rate.roundedTo(places: 2))"
            }
            return cell
            
        default:
            switch indexPath.row {
            case 0:
                let cell = tableView.dequeueReusableCell(withIdentifier: "dateCell", for: indexPath) as! TCDatePickerCell
                cell.dateLabel.text = "Start"
                cell.dateValue.text = Billable.getDateStr(unixDate: self.bill?.start)
                cell.datePicker.date = Billable.getDate(unixDate: self.bill?.start)
                return cell
                
            case 1:
                let cell = tableView.dequeueReusableCell(withIdentifier: "dateCell", for: indexPath) as! TCDatePickerCell
                cell.dateLabel.text = "Stop"
                cell.dateValue.text = Billable.getDateStr(unixDate: self.bill?.end)
                cell.datePicker.date = Billable.getDate(unixDate: self.bill?.end)
                return cell
                
            default:
                let cell = tableView.dequeueReusableCell(withIdentifier: "durationCell", for: indexPath) as! TCDurationCell

                cell.durationValue.text = Billable.getDuration(start: self.bill?.start, end: self.bill?.end)
                cell.picker.countDownDuration = Billable.getSpan(start: self.bill?.start, end: self.bill?.end)
                return cell
            }
        }
    }

}
