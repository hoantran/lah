//
//  AppDelegate.swift
//  LendAHand
//
//  Created by Hoan Tran on 10/19/17.
//  Copyright © 2017 Hoan Tran. All rights reserved.
//

import UIKit
import Firebase
import Fabric
import Crashlytics

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?


  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    Fabric.with([Crashlytics.self])
    FirebaseApp.configure()
    window = UIWindow(frame: UIScreen.main.bounds)
    window?.makeKeyAndVisible()
    
    window?.rootViewController = UINavigationController(rootViewController: LoginViewController())
    return true
  }

  func applicationWillResignActive(_ application: UIApplication) {
  }

  func applicationDidEnterBackground(_ application: UIApplication) {
  }

  func applicationWillEnterForeground(_ application: UIApplication) {
  }

  func applicationDidBecomeActive(_ application: UIApplication) {
  }

  func applicationWillTerminate(_ application: UIApplication) {
  }
}

