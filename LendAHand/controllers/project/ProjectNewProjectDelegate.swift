//
//  ProjectNewProjectDelegate.swift
//  LendAHand
//
//  Created by Hoan Tran on 11/30/17.
//  Copyright © 2017 Hoan Tran. All rights reserved.
//

import Foundation

extension ProjectViewController: CreateUpdateProjectDelegate {
  func observeCreateUpdateProject(_ prj: Project) {
    Constants.firestore.collection.projects?.addDocument(data: prj.dictionary)
  }
}
