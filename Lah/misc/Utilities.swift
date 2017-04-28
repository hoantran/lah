//
//  Utilities.swift
//  Lah
//
//  Created by Hoan Tran on 3/30/17.
//  Copyright © 2017 Pego Consulting. All rights reserved.
//

import Foundation

extension Float {
    static func random() -> Float {
        return Float(arc4random())/Float(UInt32.max)
    }
    
    static func random(min: Float, max: Float) -> Float {
        assert(min<max)
        return Float.random() * (max - min) + min
    }
    
    func roundTo(places: Int) -> Float {
        let divisor = Float(pow(10.0, Double(places)))
        let numerator = self.multiplied(by: divisor)
        return numerator.rounded() / divisor
    }
}

extension Int {
    static func random() -> Int {
        return Int(arc4random())
    }
    
    static func random(min: Int, max: Int ) -> Int {
        assert (min<max)
        let fraction = Double(arc4random()) / Double(UINT32_MAX )
        let start = (fraction * Double(max-min)).rounded()
        return Int(start) + min
    }
}

