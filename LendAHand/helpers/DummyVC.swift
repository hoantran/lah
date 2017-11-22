//
//  DummyVC.swift
//  LendAHand
//
//  Created by Hoan Tran on 11/11/17.
//  Copyright © 2017 Hoan Tran. All rights reserved.
//

import UIKit

class DummyVC: UITableViewController {
  override func viewDidLoad() {
    super.viewDidLoad()
    
    navigationItem.title = "Dummy!"
    navigationController?.navigationBar.prefersLargeTitles = true
    view.backgroundColor = UIColor.blue
    print("--- INIT ---")
  }
  
  deinit {
    print("--- DEINIT ---")
  }
  
  
}
