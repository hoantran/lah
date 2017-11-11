//
//  ClockView.swift
//  LendAHand
//
//  Created by Hoan Tran on 11/10/17.
//  Copyright © 2017 Hoan Tran. All rights reserved.
//

import UIKit

class ClockView: UIView {
  var start: Date = Date()
  
  private let CIRCLE_COUNT = 3
  var circles = [UIImageView]()
  
  var digits: UILabel = {
    let label = UILabel()
    label.text = "00:00:00"
    label.font = UIFont.systemFont(ofSize: 7, weight: .light)
    label.textColor = UIColor.black
    label.backgroundColor = UIColor.clear
    label.textAlignment = .center
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  func update() {
    let now = Date()
    let elapsed = Int(now.timeIntervalSince(start))
    let hours = Int(elapsed/(60*60))
    let minutes = Int( (elapsed - (hours*60*60))/60 )
    let seconds = Int( elapsed - (hours*60*60) - (minutes*60))
    self.digits.text = "\( String(format: "%02d", hours) ):\(String(format: "%02d", minutes)):\(String(format: "%02d", seconds))"
  }
  
  func restartAnimation() {
    layer.removeAllAnimations()
    
    let variation = Double.random(min: -0.3, max: 0.3)
    var direction = Double.random(min: -1, max: 1)
    direction = direction < 0 ? -1 : 1
    
    let metrics = [ (total: -Double.pi * 2, duration: 1.0),
                    (total:  Double.pi * 2, duration: 2.0),
                    (total: -Double.pi * 2, duration: 4.0),
                    ]
    
    for i in 0..<CIRCLE_COUNT {
      let c = self.circles[i]
      
      let rotationAnimation = CABasicAnimation()
      rotationAnimation.keyPath = "transform.rotation.z"
      rotationAnimation.toValue = metrics[i].total * direction
      rotationAnimation.duration = metrics[i].duration + variation
      rotationAnimation.isCumulative = true
      rotationAnimation.repeatCount = .infinity
      c.layer.add(rotationAnimation, forKey: "rotationAnimation")
      
      self.circles.append(c)
    }
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    backgroundColor = UIColor.clear
    
    for i in 0..<CIRCLE_COUNT {
      let c = UIImageView()
      c.translatesAutoresizingMaskIntoConstraints = false
      c.contentMode = .scaleAspectFit
      c.backgroundColor = UIColor.clear
      c.image = UIImage(named: "timer.circle.\(i+1).png")
      
      addSubview(c)
      addConstraints(format: "V:|[v0]|", views: c)
      addConstraints(format: "H:|[v0]|", views: c)
      
      self.circles.append(c)
    }
    
    addSubview(digits)
    addConstraints(format: "V:|[v0]|", views: digits)
    addConstraints(format: "H:|[v0]|", views: digits)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
