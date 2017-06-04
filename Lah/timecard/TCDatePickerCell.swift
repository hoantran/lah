//
//  TCDatePickerCell.swift
//  Lah
//
//  Created by Hoan Tran on 5/30/17.
//  Copyright © 2017 Pego Consulting. All rights reserved.
//

import UIKit

class TCDatePickerCell: UITableViewCell, CellObserver {
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var dateValue: UILabel!

    var observingCount: Int = 0 // make sure it does not remove observer too many times
    
    static let FRAME_KEY_PATH = "frame"
    
    class var expandedHeight: CGFloat { get { return 200 } }
    class var defaultHeight:  CGFloat { get { return 44  } }
    
    let myID: String = {
        return UITableViewCell.getRandomLetter()
    } ()
    
    func hideDatePickerIfNeeded() {
        datePicker.isHidden = ( frame.size.height < TCDatePickerCell.expandedHeight )
    }
    
    func observeChanges() {
        if self.observingCount < 1 {
            addObserver(self, forKeyPath: TCDatePickerCell.FRAME_KEY_PATH, options: .new, context: nil)
            print("Add: [\(self.myID)]")
        }
        self.observingCount += 1
        hideDatePickerIfNeeded()
    }
    
    func ignoreChanges() {
        if self.observingCount > 0 {
            removeObserver(self, forKeyPath: TCDatePickerCell.FRAME_KEY_PATH)
            print("Remove: [\(self.myID)]")
            self.observingCount -= 1
        }
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        print(keyPath ?? "")
        if keyPath == TCDatePickerCell.FRAME_KEY_PATH {
            hideDatePickerIfNeeded()
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    deinit {
        print("deinit")
        self.ignoreChanges()
    }

}
