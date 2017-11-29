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
    if let workerID = self.workerID, let ref = Constants.firestore.collection.workers {
      let doc = ref.document(workerID).collection(Constants.works).document(workID)
      doc.setData(work.dictionary)
    }
  }
}
