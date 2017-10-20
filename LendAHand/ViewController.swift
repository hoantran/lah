//
//  ViewController.swift
//  LendAHand
//
//  Created by Hoan Tran on 10/19/17.
//  Copyright © 2017 Hoan Tran. All rights reserved.
//

import UIKit
import FacebookLogin
import FacebookCore
import Firebase

class ViewController: UIViewController, LoginButtonDelegate {
  
  // Facebook Login using FB app doesn't dismiss Login Dialog after logging in
  // this is a known problem with iOS 11 and the FB SDK
  // https://stackoverflow.com/questions/45577898/facebook-login-doesnt-doesnt-dismiss-login-dialog-after-login
  
  // But loggin in user email/password works fine
  func loginButtonDidCompleteLogin(_ loginButton: LoginButton, result: LoginResult) {
    print(result)
    switch result {
    case .failed(let error):
      print("FACEBOOK LOGIN FAILED: \(error)")
    case .cancelled:
      print("User cancelled login.")
    case .success(let grantedPermissions, let declinedPermissions, let accessToken):
      print("Logged in!")
      print("GRANTED PERMISSIONS: \(grantedPermissions)")
      print("DECLINED PERMISSIONS: \(declinedPermissions)")
      print("ACCESS TOKEN \(accessToken)")
      
      guard let token = AccessToken.current?.authenticationToken else {
        print("Error: Could not get FB access authentication token")
        return
      }
      let credential = FacebookAuthProvider.credential(withAccessToken: token)
      Auth.auth().signIn(with: credential, completion: { (user, error) in
        if let error = error {
          print("Could not sign in with FB credential : ", error)
          return
        }
        if let displayName = user?.displayName {
          print("[\(displayName)] is logged into Firebase")
        }
      })
    }
  }
  
  func loginButtonDidLogOut(_ loginButton: LoginButton) {
    print("FB Logged out")
  }

  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    view.backgroundColor = UIColor.cyan
    navigationItem.title = "FB"
    
    if let accessToken = AccessToken.current {
      // User is logged in, use 'accessToken' here.
      print("user logged in : ", accessToken.appId, " : ", accessToken.userId ?? "")
    }
    
    let loginBtn = LoginButton(readPermissions: [.publicProfile])
    loginBtn.center = view.center
    loginBtn.delegate = self
    view.addSubview(loginBtn)
  }

}

