//
//  Billable.swift
//  Lah
//
//  Created by Hoan Tran on 3/23/17.
//  Copyright © 2017 Pego Consulting. All rights reserved.
//

import Foundation
import Firebase

struct Billable {
    // about cf time
    // http://apple.co/2kuPWBu
    
    let key     : String
    let ref     : FIRDatabaseReference?
    let rate    : Float
    let start   : Int
    let end     : Int
    let project : String
    let worker  : String
    let paid    : Int
    let note    : String
    
    init(rate: Float, start: Int, end: Int, project: String, worker: String, paid: Int, note: String, key: String = "") {
        self.key        = key
        self.ref        = nil
        self.rate       = rate
        self.start      = start
        self.end        = end
        self.project    = project
        self.worker     = worker
        self.paid       = paid
        self.note       = note
    }
    
    init?(snapshot: FIRDataSnapshot) {
        key = snapshot.key
        ref = snapshot.ref
        
        let snapshotValue   = snapshot.value as! [String: AnyObject]
        guard   let rate    = snapshotValue["rate"]     as? Float,
            let start   = snapshotValue["start"]    as? Int,
            let end     = snapshotValue["end"]      as? Int,
            let project = snapshotValue["project"]  as? String,
            let worker  = snapshotValue["worker"]   as? String,
            let paid    = snapshotValue["paid"]     as? Int,
            let note    = snapshotValue["note"]     as? String
            else { return nil }
        self.rate       = rate
        self.start      = start
        self.end        = end
        self.project    = project
        self.worker     = worker
        self.paid       = paid
        self.note       = note
    }
    
    func toAnyObject() -> Any {
        return [
            "rate"      : self.rate,
            "start"     : self.start,
            "end"       : self.end,
            "project"   : self.project,
            "worker"    : self.worker,
            "paid"      : self.paid,
            "note"      : self.note
        ]
    }
}
