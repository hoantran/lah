//
//  Project.swift
//  Lah
//
//  Created by Hoan Tran on 2/17/17.
//  Copyright © 2017 Pego Consulting. All rights reserved.
//

import Foundation
//import Firebase

struct Project {
    let key             : String
//    let ref             : FIRDatabaseReference?
    let name            : String
    var isCompleted     : Bool
    
    init?(name: String?, isCompleted: Bool, key: String = "") {
        guard let name = name else { return nil }
        
        self.key            = key
//        self.ref            = nil
        self.name           = name
        self.isCompleted    = isCompleted
    }
    
//    init?(snapshot: FIRDataSnapshot) {
//        key = snapshot.key
//        ref = snapshot.ref
//        let snapshotValue = snapshot.value as! [String: AnyObject]
//        guard   let name            = snapshotValue["name"]         as? String,
//            let isCompleted     = snapshotValue["isCompleted"]  as? Bool
//            else { return nil }
//        self.name           = name
//        self.isCompleted    = isCompleted
//    }
    
    func toAnyObject() -> Any {
        return [
            "name": name,
            "isCompleted": isCompleted
        ]
    }
}
