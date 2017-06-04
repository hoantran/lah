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

extension Billable: CustomStringConvertible {
    public var description: String {
        return "\n[\(key)] \(rate) \(start) - \(end)"
    }
}

// UI Helper
extension Billable {
    static func getDuration(start: Int, end: Int) -> String {
        let span = end - start;
        let hrs = Int(span/(60 * 60))
        let mins = Int((span - (hrs * 60 * 60))/60)
        
        return "\(hrs)" + "h " + "\(mins)" + "m"
    }
    
    static func getTotal(start: Int, end: Int, rate: Float) -> String {
        let span = end - start;
        let hours:Float = Float(Float(span) / Float(3600))
        let payable: Float = rate * hours
        
        return payable.roundedTo(places: 2)
    }
    
    static func getDateStr(unixDate: Int?) -> String {
        if let date = unixDate {
            let epochDate = Date(timeIntervalSince1970: TimeInterval(date))
            let dayTimePeriodFormatter = DateFormatter()
            dayTimePeriodFormatter.dateFormat = "MMM dd, YYYY  hh:mm a"
            
            return dayTimePeriodFormatter.string(from: epochDate)
        } else {
            return ""
        }
    }
    
    static func getDate(unixDate: Int?) -> Date {
        if let date = unixDate {
            return Date(timeIntervalSince1970: TimeInterval(date))
        } else {
            return Date()
        }
    }
}


