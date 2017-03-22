//
//  ContainerViewController.swift
//  Lah
//
//  Created by Hoan Tran on 3/17/17.
//  Copyright © 2017 Pego Consulting. All rights reserved.
//

// http://dennissuratna.com/slide-out-navigation-swift/
// https://www.raywenderlich.com/78568/create-slide-out-navigation-panel-swift

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

    var menuShown = false
    @IBAction func swipeLeft(_ sender: Any) {
        hideMenu()
    }
    
    @IBAction func swipeRight(_ sender: Any) {
        showMenu()
    }
    
    @IBOutlet var tap: UITapGestureRecognizer!
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        let point:CGPoint = touch.location(in: self.rightViewController?.view)
        if point.x > 0 && menuShown {
            hideMenu()
            return true
        }
        return false
    }
    
    func showMenu() {
        showShadow(true)
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
            self.rightViewController?.view.frame.origin.x = self.view.frame.origin.x + 235
        }, completion: { _ in
            self.menuShown = true
        })
    }
    
    func hideMenu() {
        showShadow(false)
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
            self.rightViewController?.view.frame.origin.x = self.view.frame.origin.x
        }, completion: {_ in
            self.menuShown = false
        })
    }
    
    func showShadow(_ shouldShowShadow: Bool) {
        if shouldShowShadow {
            self.rightViewController?.view.layer.shadowOpacity = 0.8
        } else {
            self.rightViewController?.view.layer.shadowOpacity = 0.0
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setInitialControllers()
        addNewVCObservers()
        self.tap.delegate = self
    }
    
    func setInitialControllers() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let mainNavigationController: UINavigationController = storyboard.instantiateViewController(withIdentifier: "NavVC") as! UINavigationController
        let menuViewController: MenuViewController           = storyboard.instantiateViewController(withIdentifier: "MenuVC") as! MenuViewController
        
        self.leftViewController = menuViewController
        self.rightViewController = mainNavigationController
        
    }
    
    func addNewVCObservers() {
        let center = NotificationCenter.default
        center.addObserver(forName: .vcSelected, object: nil, queue: nil) { _ in
            self.hideMenu()
        }
        center.addObserver(forName: .menuTapped, object: nil, queue: nil) { _ in
            self.showMenu()
        }
    }
    
    
    
}









