//
//  NavigationViewController.swift
//  Lah
//
//  Created by Hoan Tran on 3/18/17.
//  Copyright © 2017 Pego Consulting. All rights reserved.
//

import UIKit

class NavigationViewController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        addObservers()
    }

    func addObservers() {
        let center = NotificationCenter.default
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        center.addObserver(forName: .workersSelected, object: nil, queue: nil) { _ in
            let mvc = storyboard.instantiateViewController(withIdentifier: WorkerViewController.storyboardID)
            self.setViewControllers([mvc], animated: true)
        }
        
        center.addObserver(forName: .projectsSelected, object: nil, queue: nil) { _ in
            let mvc = storyboard.instantiateViewController(withIdentifier: ProjectViewController.storyboardID)
            self.setViewControllers([mvc], animated: true)
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
