//
//  Worker.swift
//  Lah
//
//  Created by Hoan Tran on 3/13/17.
//  Copyright © 2017 Pego Consulting. All rights reserved.
//

import Foundation
import Firebase

struct Worker {
    
    let key         : String
    let ref         : FIRDatabaseReference?
    let firstName   : String
    let lastName    : String
    let phone       : String
    let email       : String
    let rate        : Float
    
    init?(firstName: String?, lastName: String?, phone: String?, email: String?, rate: Float?, key: String = "") {
        guard   let firstName = firstName,
                let lastName = lastName,
                let phone = phone,
                let email = email,
                let rate = rate
            else { return nil }
        
        self.key        = key
        self.ref        = nil
        self.firstName  = firstName
        self.lastName   = lastName
        self.phone      = phone
        self.email      = email
        self.rate       = rate
    }
    
    init?(snapshot: FIRDataSnapshot) {
        key = snapshot.key
        ref = snapshot.ref
        
        print(snapshot.value ?? "no value")
        guard let snapshotValue = snapshot.value as? [String: AnyObject] else { print ("snap is invalid"); return nil }
        
        guard   let firstName   = snapshotValue["firstName"]    as? String,
            let lastName    = snapshotValue["lastName"]     as? String,
            let phone       = snapshotValue["phone"]        as? String,
            let email       = snapshotValue["email"]        as? String,
            let rate        = snapshotValue["rate"]         as? Float
            else { return nil }
        
        self.firstName  = firstName
        self.lastName   = lastName
        self.phone      = phone
        self.email      = email
        self.rate       = rate
    }
    
    func toAnyObject() -> Any {
        return [
            "firstName" : firstName,
            "lastName"  : lastName,
            "phone"     : phone,
            "email"     : email,
            "rate"      : rate
        ]
    }
}

extension Worker: CustomStringConvertible {
    public var description: String {
        return "\n[\(key)] \(firstName) \(lastName) :\(rate)"
    }
}

extension Worker: Equatable {
    public static func ==(lhs: Worker, rhs: Worker) -> Bool {
        if lhs.key != "" && rhs.key != "" && lhs.key == rhs.key {
            return true
        } else {
            return false
        }
    }
}



