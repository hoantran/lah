//
//  Constants.swift
//  LendAHand
//
//  Created by Hoan Tran on 10/20/17.
//  Copyright © 2017 Hoan Tran. All rights reserved.
//

import UIKit
import FirebaseFirestore

struct Constants {
  static let firestoreRoot = Firestore.firestore()
  static let firestoreWorkerCollection = Constants.firestoreRoot.collection("workers")
  static let firestoreProjectCollection = Constants.firestoreRoot.collection("projects")
  static let firestoreCurrentCollection = Constants.firestoreRoot.collection("currents")
  static let works = "works"
  static let baseColor = UIColor(hex: "0x89CFF0")
  static let highlightColor = UIColor(hex: "0xdaf0fa")
  static let bkgColor = UIColor(hex: "0xf5fbfd")
  static let fieldBkgColor = UIColor(hex: "0xdaf0fa")
}

