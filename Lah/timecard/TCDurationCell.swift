//
//  TCDurationCell.swift
//  Lah
//
//  Created by Hoan Tran on 6/4/17.
//  Copyright © 2017 Pego Consulting. All rights reserved.
//

import UIKit

class TCDurationCell: TCBasePickerCell {
    @IBOutlet weak var durationValue: UILabel!
    @IBOutlet weak var picker: UIDatePicker!

    override func getDatePicker() -> UIDatePicker? {
        return self.picker
    }
    
}
