//
//  BillableTimeCardDelegate.swift
//  LendAHand
//
//  Created by Hoan Tran on 11/21/17.
//  Copyright © 2017 Hoan Tran. All rights reserved.
//

import UIKit

extension BillableViewController: TimeCardDelegate {
  func save(workID: String, work: Work) {
    Constants.firestore.collection.works?.document(workID).setData(work.dictionary)
  }
}
