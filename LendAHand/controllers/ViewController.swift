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
    var workers: LocalCollection<Worker>!
    var projects: LocalCollection<Project>!
  
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
        self.userLoggedIn()
      })
    }
  }
  
  func userLoggedIn() {
    writeWorkers()
    writeProjects()
    setupWorkerObservation()
    setupProjectObservation()
    self.workers.listen()
    self.projects.listen()
  }
  
  func loginButtonDidLogOut(_ loginButton: LoginButton) {
    print("FB Logged out")
  }

//  Simulator
//  [ 0E672A84-A007-4140-B71F-187F8A2C99FE:ABPerson ] Yanni Satari
//  R[ 0E672A84-A007-4140-B71F-187F8A2C99FE:ABPerson ] Yanni Satari
//  [ 410FE041-5C4E-48DA-B4DE-04C15EA3DBAC ] John Appleseed
//  R[ 410FE041-5C4E-48DA-B4DE-04C15EA3DBAC ] John Appleseed

  func writeWorkers() {
    let worker = Worker(contact: "0E672A84-A007-4140-B71F-187F8A2C99FE:ABPerson", rate: 14.70)
    let workerRef = Constants.firestoreWorkerCollection.addDocument(data: worker.dictionary)
    print(workerRef)
  }
  
  func writeProjects() {
    let project = Project(contact: "410FE041-5C4E-48DA-B4DE-04C15EA3DBAC", name: "SpaceX", completed: false)
    let projectRef = Constants.firestoreProjectCollection.addDocument(data: project.dictionary)
    print("Projects:", projectRef)
  }
  
  func setupWorkerObservation() {
    let query = Constants.firestoreWorkerCollection
    self.workers = LocalCollection(query: query) { [unowned self] (changes) in
      print("..............: Workers")
      changes.forEach(){ print ("[", $0.type, "]", $0) }
    }
  }
  
  func setupProjectObservation() {
    let query = Constants.firestoreProjectCollection
    self.projects = LocalCollection(query: query) { [unowned self] (changes) in
      print("..............: Projects")
      changes.forEach(){ print ("[", $0.type, "]", $0) }
    }
  }
  
  deinit {
    self.workers.stopListening()
    self.projects.stopListening()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
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

