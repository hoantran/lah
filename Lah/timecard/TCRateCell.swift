//
//  TCRateCell.swift
//  Lah
//
//  Created by Hoan Tran on 5/30/17.
//  Copyright © 2017 Pego Consulting. All rights reserved.
//

import UIKit

class TCRateCell: UITableViewCell, CellObserver {
    @IBOutlet weak var rate: UITextField!

    let rateDelegate: CurrencyTextFieldDelegate = {
        let delg = CurrencyTextFieldDelegate()
        return delg
    } ()
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
        print("cell selected")
    }
    
    func observeChanges(){}
    func ignoreChanges(){}

}
