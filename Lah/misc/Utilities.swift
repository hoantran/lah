//
//  Utilities.swift
//  Lah
//
//  Created by Hoan Tran on 3/30/17.
//  Copyright © 2017 Pego Consulting. All rights reserved.
//

import UIKit

extension Float {
    static func random() -> Float {
        return Float(arc4random())/Float(UInt32.max)
    }
    
    static func random(min: Float, max: Float) -> Float {
        assert(min<max)
        return Float.random() * (max - min) + min
    }
    
    func roundedTo(places: Int) -> String {
        let divisor:Float = Float(pow(10.0, Double(places)))
        let result = Darwin.round(self * divisor) / divisor
        let str = String(format: "%.\(places)f", result)

        return str
//        let final = (str as NSString).floatValue
//        return final
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

// http://kevinvanderlugt.com/generating-a-random-letter-string-in-swift/
extension UITableViewCell {
    static func getRandomLetter() -> String {
        let uppercaseLetters = Array(65...90).map {String(UnicodeScalar($0))}
        let randomIndex = arc4random_uniform(UInt32(uppercaseLetters.count))
        return uppercaseLetters[Int(randomIndex)]
    }
}
