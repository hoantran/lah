//
//  CurrencyTextFieldDelegate.swift
//  Lah
//
//  Created by Hoan Tran on 3/10/17.
//  Copyright © 2017 Pego Consulting. All rights reserved.
//

import UIKit

class CurrencyTextFieldDelegate: NSObject, UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if string.characters.count < 1 {
            return true
        }
        
        do {
            let newText:NSString = ( textField.text ?? "") as NSString
            var newString = newText.replacingCharacters(in: range, with: string)
            let expression = "^([0-9]+)?(\\.([0-9]{1,2})?)?$"
            let regex = try NSRegularExpression(pattern: expression, options: .caseInsensitive )
            let numberOfMatches = regex.numberOfMatches(in: newString, options: [], range: NSRange(location: 0, length: newString.characters.count))
            if numberOfMatches == 0 {
                return false
            }
        }
        catch let error {
            print(error)
        }
        return true

    }
}
