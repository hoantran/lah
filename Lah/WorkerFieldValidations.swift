//
//  WorkerFieldValidations.swift
//  Lah
//
//  Created by Hoan Tran on 3/10/17.
//  Copyright © 2017 Pego Consulting. All rights reserved.
//

import Foundation


class WorkerFieldValidations {
    static let PHONE_NUMBER_REGEX = "^(\\()?\\d{3}(\\)?)(\\.)?([- ])?\\d{3}(\\.)?(-)?\\d{4}$"
    static let EMAIL_REGEX = "^(?:(?:(?:(?: )*(?:(?:(?:\\t| )*\\r\\n)?(?:\\t| )+))+(?: )*)|(?: )+)?(?:(?:(?:[-A-Za-z0-9!#$%&’*+/=?^_'{|}~]+(?:\\.[-A-Za-z0-9!#$%&’*+/=?^_'{|}~]+)*)|(?:\"(?:(?:(?:(?: )*(?:(?:[!#-Z^-~]|\\[|\\])|(?:\\\\(?:\\t|[ -~]))))+(?: )*)|(?: )+)\"))(?:@)(?:(?:(?:[A-Za-z0-9](?:[-A-Za-z0-9]{0,61}[A-Za-z0-9])?)(?:\\.[A-Za-z0-9](?:[-A-Za-z0-9]{0,61}[A-Za-z0-9])?)*)|(?:\\[(?:(?:(?:(?:(?:[0-9]|(?:[1-9][0-9])|(?:1[0-9][0-9])|(?:2[0-4][0-9])|(?:25[0-5]))\\.){3}(?:[0-9]|(?:[1-9][0-9])|(?:1[0-9][0-9])|(?:2[0-4][0-9])|(?:25[0-5]))))|(?:(?:(?: )*[!-Z^-~])*(?: )*)|(?:[Vv][0-9A-Fa-f]+\\.[-A-Za-z0-9._~!$&'()*+,;=:]+))\\])))(?:(?:(?:(?: )*(?:(?:(?:\\t| )*\\r\\n)?(?:\\t| )+))+(?: )*)|(?: )+)?$"
    
    static func isCorrectRegex(expression:String, str: String) -> Bool {
        do {
            let regex = try NSRegularExpression(pattern: expression, options: .caseInsensitive )
            let numberOfMatches = regex.numberOfMatches(in: str, options: [], range: NSRange(location: 0, length: str.characters.count))
            if numberOfMatches == 0 {
                return false
            }
        }
        catch let error {
            print(error)
        }
        return true
    }

    // (111) 111-1111, 111.111.1111, 1111111111
    static func isPhoneNumber(_ str: String) ->Bool {
        return self.isCorrectRegex(expression: PHONE_NUMBER_REGEX, str: str)
    }
    
    static func isEmail(_ str: String) -> Bool {
        return self.isCorrectRegex(expression: EMAIL_REGEX, str: str)
    }

    
}
