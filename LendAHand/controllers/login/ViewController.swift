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
    var currents: LocalCollection<Current>!
  
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
      print("user just logged in : ", accessToken.appId, " : ", accessToken.userId ?? "")
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
    writeProjects()
    setupProjectObservation()
    self.projects.listen()
    
    writeWorkers()
    setupWorkerObservation()
    self.workers.listen()
    
    setupCurrentObservation()
    self.currents.listen()
  }
  
  deinit {
    self.workers.stopListening()
    self.projects.stopListening()
    self.currents.stopListening()
  }
  
  func loginButtonDidLogOut(_ loginButton: LoginButton) {
    print("FB Logged out")
    do {
      try Auth.auth().signOut()
    } catch let signOutError as NSError {
      print ("Error signing out: %@", signOutError)
    }
  }

//  Simulator
//  [ 0E672A84-A007-4140-B71F-187F8A2C99FE:ABPerson ] Yanni Satari
//  R[ 0E672A84-A007-4140-B71F-187F8A2C99FE:ABPerson ] Yanni Satari
//  [ 410FE041-5C4E-48DA-B4DE-04C15EA3DBAC ] John Appleseed
//  R[ 410FE041-5C4E-48DA-B4DE-04C15EA3DBAC ] John Appleseed

  func writeWorkers() {
    let worker = Worker(contact: "0E672A84-A007-4140-B71F-187F8A2C99FE:ABPerson", rate: 14.70)
    if let workerRef = Constants.firestore.collection.workers?.addDocument(data: worker.dictionary) {
      print(workerRef)
    }
  }
  
  func writeProjects() {
//    let project = Project(contact: "410FE041-5C4E-48DA-B4DE-04C15EA3DBAC", name: "SpaceX", completed: false)
    let project = Project(contact: nil, name: "SpaceX", completed: false)
    if let projectRef = Constants.firestore.collection.projects?.addDocument(data: project.dictionary) {
      print("Projects:", projectRef)
    }
  }
  
  func setupWorkerObservation() {
    if let query = Constants.firestore.collection.workers {
      self.workers = LocalCollection(query: query) { [unowned self] (changes) in
        print("..............: Workers")
        changes.forEach(){ print ("[", $0.type, "]", $0) }
        if self.projects != nil && self.projects.count > 0 {
          let projectID = self.projects.documents[0].reference.documentID
          let worker = self.workers[0]
          let start = Date()
          let work = Work(rate: worker.rate, isPaid: false, start: start, project: projectID, stop: nil, note: nil)
          let collection = self.workers.documents[0].reference.collection(Constants.works)
          let newWork = collection.document()
          newWork.setData(work.dictionary)
          newWork.setData(work.dictionary) { error in
            if let error = error {
              print("Couldn't set new work:", error)
              return
            }
            let current = Current(
                worker: self.workers.documents[0].reference.documentID,
                start: Date(),
                rate: 12.0)
            Constants.firestore.collection.currents?.addDocument(data: current.dictionary)
          }
        }
      }
    }
  }
  
  func setupProjectObservation() {
    if let query = Constants.firestore.collection.projects {
      self.projects = LocalCollection(query: query) { [unowned self] (changes) in
        print("..............: Projects")
        changes.forEach(){ print ("[", $0.type, "]", $0) }
      }
    }
  }
  
  func setupCurrentObservation() {
    if let query = Constants.firestore.collection.currents {
      self.currents = LocalCollection(query: query) { [unowned self] (changes) in
        print("..............: Currents")
        changes.forEach(){ print ("[", $0.type, "]", $0) }
      }
    }
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    view.backgroundColor = UIColor.cyan
    navigationItem.title = "FB"
    
    if let uid = Auth.auth().currentUser?.uid {
      print("But Firebase already logged in: ", uid)
    }
    
    if let accessToken = AccessToken.current {
      // User is logged in, use 'accessToken' here.
      print("user logged in : ", accessToken.appId, " : ", accessToken.userId ?? "")
    }
    
    let loginBtn = LoginButton(readPermissions: [.publicProfile])
    loginBtn.frame = CGRect(x: 0, y: 0, width: 300, height: 300)
    loginBtn.center = view.center
    loginBtn.delegate = self
    view.addSubview(loginBtn)
  }

}

