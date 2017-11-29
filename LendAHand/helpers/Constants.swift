//
//  Constants.swift
//  LendAHand
//
//  Created by Hoan Tran on 10/20/17.
//  Copyright © 2017 Hoan Tran. All rights reserved.
//

import UIKit
import FirebaseFirestore
import Firebase

struct Constants {
  static let works = "works"
  static let rate = "rate"
  static let users = "users"
  
  public struct Color {
    public let base = UIColor(hex: "0x89CFF0")
    public let highlight = UIColor(hex: "0xdaf0fa")
    public let bkg = UIColor(hex: "0xf5fbfd")
    public let fieldBkg = UIColor(hex: "0xdaf0fa")
    public let amount = UIColor(hex: "0xf47200")
  }
  public static var color: Color {
    return Color()
  }
  
  public struct KFirestore {
    public let root = Firestore.firestore()

    public struct KCollection {
      public var workers:CollectionReference? {
        return Constants.firestore.collection.getCollection("workers")
      }
      public var projects:CollectionReference? {
        return Constants.firestore.collection.getCollection("projects")
      }
      public var currents:CollectionReference? {
        return Constants.firestore.collection.getCollection("currents")
      }
      
      public func getCollection(_ name: String)->CollectionReference? {
        if let id = Auth.auth().currentUser?.uid {
          return Constants.firestore.root.collection(Constants.users).document(id).collection(name)
        }
        return nil
      }
    }
    
    public var collection: KCollection {
      return KCollection()
    }
  }
  public static var firestore: KFirestore {
    return KFirestore()
  }
  
  public struct Margin {
    public let left:CGFloat = 20.0
    public let right:CGFloat = 20.0
    public let top:CGFloat = 8.0
    public let bottom:CGFloat = 8.0
  }
  public static var margin: Margin {
    return Margin()
  }
  
}

