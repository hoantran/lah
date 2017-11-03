//
//  ContainerViewController.swift
//  LendAHand
//
//  Created by Hoan Tran on 10/31/17.
//  Copyright © 2017 Hoan Tran. All rights reserved.
//

import UIKit

class ContainerViewController: UIViewController, UIGestureRecognizerDelegate {
  var leftViewController: UIViewController? {
    willSet {
      if self.leftViewController != nil {
        if self.leftViewController?.view != nil {
          self.leftViewController?.view.removeFromSuperview()
        }
        self.leftViewController?.removeFromParentViewController()
      }
    }
    didSet {
      self.view.addSubview(self.leftViewController!.view)
      self.addChildViewController(self.leftViewController!)
    }
  }
  
  var rightViewController: UIViewController? {
    willSet {
      if self.rightViewController != nil {
        if self.rightViewController?.view != nil {
          self.rightViewController?.view.removeFromSuperview()
        }
        self.rightViewController?.removeFromParentViewController()
      }
    }
    didSet {
      self.view.addSubview(self.rightViewController!.view)
      self.addChildViewController(self.rightViewController!)
    }
  }
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setInitialViewControllers()
    setupGestures()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    addObservers()
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    NotificationCenter.default.removeObserver(self)
  }
  
  func setInitialViewControllers() {
    self.leftViewController = MenuViewController()
    self.rightViewController = NavigationViewController()
  }
  
  func setupGestures() {
    let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipeRight))
    rightSwipe.direction = .right
    view.addGestureRecognizer(rightSwipe)
    
    let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipeLeft))
    leftSwipe.direction = .left
    view.addGestureRecognizer(leftSwipe)
    
    let tap = UITapGestureRecognizer()
    tap.delegate = self
    tap.numberOfTapsRequired = 1
    view.addGestureRecognizer(tap)
  }
  
  @objc func handleSwipeRight(){
    showMenu()
  }
  
  @objc func handleSwipeLeft(){
    hideMenu()
  }
  
  func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
    let point = touch.location(in: self.rightViewController?.view)
    if point.x > 0 && menuShown {
      hideMenu()
      return true
    } else {
      return false
    }
  }
  
  var menuShown = false
  
  @objc func showMenu() {
    adjustShadow(true)
    UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
      self.rightViewController?.view.frame.origin.x = self.view.frame.origin.x + 235
    }, completion: {_ in
      self.menuShown = true
    })
  }
  
  @objc func hideMenu() {
    adjustShadow(false)
    UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
      self.rightViewController?.view.frame.origin.x = self.view.frame.origin.x
    }, completion: {_ in
      self.menuShown = false
    })
  }
  
  func adjustShadow(_ shouldShowShadow: Bool) {
    if shouldShowShadow {
      self.rightViewController?.view.layer.shadowOpacity = 0.8
    } else {
      self.rightViewController?.view.layer.shadowOpacity = 0.0
    }
  }
  
  func addObservers() {
    let center = NotificationCenter.default
    center.addObserver(self, selector: #selector(hideMenu), name: .workersSelected, object: nil)
    center.addObserver(self, selector: #selector(hideMenu), name: .projectsSelected, object: nil)
    center.addObserver(self, selector: #selector(showMenu), name: .menuTapped, object: nil)
  }
}




