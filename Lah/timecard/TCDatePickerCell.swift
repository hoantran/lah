//
//  TCDatePickerCell.swift
//  Lah
//
//  Created by Hoan Tran on 5/30/17.
//  Copyright © 2017 Pego Consulting. All rights reserved.
//

import UIKit

class TCDatePickerCell: TCBasePickerCell {
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var dateValue: UILabel!

    override func getDatePicker() -> UIDatePicker? {
        return self.datePicker
    }
    

}
