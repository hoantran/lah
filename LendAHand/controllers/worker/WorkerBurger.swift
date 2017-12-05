//
//  WorkerBurger.swift
//  LendAHand
//
//  Created by Hoan Tran on 12/5/17.
//  Copyright © 2017 Hoan Tran. All rights reserved.
//

import UIKit

extension WorkerViewController:BurgerButton {
  func addTarget(_ btn: UIButton) {
    btn.addTarget(self, action: #selector(handleBugerButtonTap), for: .touchUpInside)
  }
  @objc func handleBugerButtonTap() {
    postMenuTapped()
  }
}

extension WorkerViewController:CreateUpdateWorkerDelegate {
  func observeCreateUpdateWorker(_ worker: Worker) {
    Constants.firestore.collection.workers?.addDocument(data: worker.dictionary)
  }
}

