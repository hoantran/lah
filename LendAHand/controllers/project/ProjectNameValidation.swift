//
//  ProjectNameValidation.swift
//  LendAHand
//
//  Created by Hoan Tran on 11/2/17.
//  Copyright © 2017 Hoan Tran. All rights reserved.
//

import UIKit

class ProjectNameValidation: NSObject, UITextFieldDelegate {
  var barItem:UIBarButtonItem?
  
  
  func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
    if string.count > 0 {
      barItem?.isEnabled = true
    }
    return true
  }
}
