//
//  Constants.swift
//  LendAHand
//
//  Created by Hoan Tran on 10/20/17.
//  Copyright © 2017 Hoan Tran. All rights reserved.
//

import Foundation
import FirebaseFirestore

struct Constants {
  static let firestoreRoot = Firestore.firestore()
  static let firestoreWorkerCollection = Constants.firestoreRoot.collection("workers")
  static let firestoreProjectCollection = Constants.firestoreRoot.collection("projects")
  static let firestoreCurrentCollection = Constants.firestoreRoot.collection("currents")
  static let works = "works"
}

