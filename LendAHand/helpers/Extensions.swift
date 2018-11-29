//
//  Extensions.swift
//  LendAHand
//
//  Created by Hoan Tran on 11/1/17.
//  Copyright © 2017 Hoan Tran. All rights reserved.
//

import UIKit

extension Notification.Name {
  static let workersSelected = Notification.Name("workersSelected")
  static let projectsSelected = Notification.Name("projectsSelected")
  static let logoutSelected = Notification.Name("logoutSelected")
  static let menuTapped = Notification.Name("menuTapped")
  static let timerForWorkerFired = Notification.Name("workerTimerFired")
}

extension Date {
  // return elapsed time from this date to now, in form of 00:00:00
  func elapsed()->String{
    let now = Date()
    let elapsed = Int(now.timeIntervalSince(self))
    if elapsed <= 0 {
      return "00:00:00"
    } else {
      let hours = Int(elapsed/(60*60))
      let minutes = Int( (elapsed - (hours*60*60))/60 )
      let seconds = Int( elapsed - (hours*60*60) - (minutes*60))
      return "\( String(format: "%02d", hours) ):\(String(format: "%02d", minutes)):\(String(format: "%02d", seconds))"
    }
  }
}

extension UIColor {
  static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
    return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
  }
  
  // https://crunchybagel.com/working-with-hex-colors-in-swift-3/
  convenience init(hex: String) {
    let scanner = Scanner(string: hex)
    scanner.scanLocation = 0
    
    var rgbValue: UInt64 = 0
    
    if !scanner.scanHexInt64(&rgbValue) {
      print("Could not convert the value [\(hex)]")
    }
    
    let r = (rgbValue & 0xff0000) >> 16
    let g = (rgbValue & 0xff00) >> 8
    let b = rgbValue & 0xff
    
    self.init(
      red: CGFloat(r) / 0xff,
      green: CGFloat(g) / 0xff,
      blue: CGFloat(b) / 0xff, alpha: 1
    )
  }
}

extension UIApplication {
  class func topViewController(base: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
    if let nav = base as? UINavigationController {
      return topViewController(base: nav.visibleViewController)
    }
    if let tab = base as? UITabBarController {
      if let selected = tab.selectedViewController {
        return topViewController(base: selected)
      }
    }
    if let presented = base?.presentedViewController {
      return topViewController(base: presented)
    }
    return base
  }
}

extension UIView {
  func addConstraints(format: String, views: UIView...) {
    var viewDictionary = [String: UIView]()
    for (index, view) in views.enumerated() {
      let key = "v\(index)"
      viewDictionary[key] = view
      view.translatesAutoresizingMaskIntoConstraints = false
    }
    
    addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: viewDictionary))
  }
}

extension Double {
  static func random() -> Double {
    return Double(arc4random())/Double(UInt32.max)
  }
  
  static func random(min: Double, max: Double) -> Double {
    assert(min<max)
    return Double.random() * (max - min) + min
  }
}

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
  }
}

