//
//  Project.swift
//  Lah
//
//  Created by Hoan Tran on 2/17/17.
//  Copyright © 2017 Pego Consulting. All rights reserved.
//

import Foundation
import Firebase

struct Project {
    let key             : String
    let name            : String
    var isCompleted     : Bool
    let ref             : FIRDatabaseReference?

    init?(name: String?, isCompleted: Bool, key: String = "") {
        guard let name = name else { return nil }
        
        self.key            = key
        self.name           = name
        self.isCompleted    = isCompleted
        self.ref            = nil
    }
    
    func toAnyObject() -> Any {
        return [
            "name": name,
            "isCompleted": isCompleted
        ]
    }
}


extension Project {
    init?(snapshot: FIRDataSnapshot) {
        key = snapshot.key
        ref = snapshot.ref
        let snapshotValue = snapshot.value as! [String: AnyObject]
        guard   let name            = snapshotValue["name"]         as? String,
            let isCompleted     = snapshotValue["isCompleted"]  as? Bool
            else { return nil }
        self.name           = name
        self.isCompleted    = isCompleted
    }
}

extension Project: CustomStringConvertible {
    public var description: String {
        return "\n[\(key)] \(name):\(isCompleted)"
    }
}

extension Project: Equatable {
    public static func ==(lhs: Project, rhs: Project) -> Bool {
        if lhs.key != "" && rhs.key != "" && lhs.key == rhs.key {
            return true
        } else {
            return false
        }
    }
}
