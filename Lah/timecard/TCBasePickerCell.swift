//
//  TCBasePickerCell.swift
//  Lah
//
//  Created by Hoan Tran on 6/4/17.
//  Copyright © 2017 Pego Consulting. All rights reserved.
//

import UIKit

class TCBasePickerCell: UITableViewCell, CellObserver {
    var observingCount: Int = 0 // make sure it does not remove observer too many times
    
    static let FRAME_KEY_PATH = "frame"
    
    static var expandedHeight: CGFloat { get { return 200 } }
    static var defaultHeight:  CGFloat { get { return 44  } }
    
    func getDatePicker() -> UIDatePicker? {
        return nil
    }
    
    let myID: String = {
        return UITableViewCell.getRandomLetter()
    } ()
    
    func hideDatePickerIfNeeded() {
        if let picker = getDatePicker() {
            picker.isHidden = frame.size.height < TCBasePickerCell.expandedHeight
        }
    }
    
    func observeChanges() {
        if self.observingCount < 1 {
            addObserver(self, forKeyPath: TCBasePickerCell.FRAME_KEY_PATH, options: .new, context: nil)
            print("Add: [\(self.myID)]")
        }
        self.observingCount += 1
        hideDatePickerIfNeeded()
    }
    
    func ignoreChanges() {
        if self.observingCount > 0 {
            removeObserver(self, forKeyPath: TCBasePickerCell.FRAME_KEY_PATH)
            print("Remove: [\(self.myID)]")
            self.observingCount -= 1
        }
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        print(keyPath ?? "")
        if keyPath == TCBasePickerCell.FRAME_KEY_PATH {
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
