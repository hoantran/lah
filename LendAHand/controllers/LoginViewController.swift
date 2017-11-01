//
//  LoginViewController.swift
//  LendAHand
//
//  Created by Hoan Tran on 10/23/17.
//  Copyright © 2017 Hoan Tran. All rights reserved.
//

import UIKit
import FacebookLogin
import FacebookCore
import Firebase


class LoginViewController: UIViewController, LoginButtonDelegate {

  func loginButtonDidCompleteLogin(_ loginButton: LoginButton, result: LoginResult) {
    switch result {
    case .failed(let error):
      print("FACEBOOK LOGIN FAILED: \(error)")
    case .cancelled:
      print("User cancelled login.")
    case .success:
      firebaseLogin()
    }
  }
  
  func firebaseLogin() {
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
      self.userLoggedIn()
    })
  }

  func isFirebaseLoggedIn()->Bool {
    return Auth.auth().currentUser?.uid != nil
  }
  
  func isFBLoggedIn()->Bool {
    return AccessToken.current?.authenticationToken != nil
  }
  
  func userLoggedIn() {
    if let user = Auth.auth().currentUser {
      print("[\(user.displayName ?? "" )] is logged into Firebase")
    }
    showFBLoginButton()
  }
  
  func loginButtonDidLogOut(_ loginButton: LoginButton) {
    print("FB Logged out")
    do {
      try Auth.auth().signOut()
    } catch let signOutError as NSError {
      print ("Error signing out: %@", signOutError)
    }
  }

  func showFBLoginButton() {
    let loginBtn = LoginButton(readPermissions: [.publicProfile])
    loginBtn.center = view.center
    loginBtn.delegate = self
    view.addSubview(loginBtn)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    navigationItem.title = "Logging On"
    view.backgroundColor = UIColor.cyan

    if isFirebaseLoggedIn() {
      userLoggedIn()
    } else {
      if isFBLoggedIn() {
        firebaseLogin()
      } else {
        showFBLoginButton()
      }
    }
  }
}
