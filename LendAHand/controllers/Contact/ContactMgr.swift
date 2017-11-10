//
//  ContactMgr.swift
//  LendAHand
//
//  Created by Hoan Tran on 11/3/17.
//  Copyright © 2017 Hoan Tran. All rights reserved.
//

import UIKit
import Contacts
import ContactsUI

class ContactMgr: NSObject, CNContactPickerDelegate {
  static let shared = ContactMgr()
  private override init(){}
  
  func fetchName(_ id: String, completion: @escaping (String?)->Void) {
    fetch(id) { retrievedContact in
      //      let formatter = CNContactFormatter()
      //      cell.textLabel?.text = formatter.string(from: contact)
      var name:String?
      if let contact = retrievedContact {
        name = contact.givenName + " " + contact.familyName
      }
      completion(name)
    }
  }
  
  func fetch(_ id: String, completion: @escaping (CNContact?)->Void)  {
    requestContactAccess{ isAllowed in
      var contact: CNContact?
      
      if isAllowed {
        let store = CNContactStore()
        let keysToFetch = [CNContactGivenNameKey, CNContactFamilyNameKey]
        do {
          contact = try store.unifiedContact(withIdentifier: id, keysToFetch: keysToFetch as [CNKeyDescriptor])
        } catch {
          print("exception encountered while fetching \(id)")
        }
      } else {
        print("Not allowed to have contact access")
      }
      completion(contact)
    }
  }
  
  func requestContactAccess(completion: @escaping (Bool)->Void ) {
    let store = CNContactStore()
    
    switch CNContactStore.authorizationStatus(for: .contacts){
    case .authorized:
      completion(true)
    case .notDetermined:
      store.requestAccess(for: .contacts){succeeded, err in
        guard err == nil && succeeded else{
          completion(false)
          return
        }
        completion(true)
      }
    default:
      print("Encountered an unhandled case while requesting access to contacts")
      completion(false)
    }
  }
  
  func listContact() {
    let controller = CNContactPickerViewController()
    controller.delegate = self
    let navController = UIApplication.shared.keyWindow?.rootViewController?.navigationController
    navController?.present(controller, animated: true, completion: nil)
  }
  
  func contactPicker(_ picker: CNContactPickerViewController, didSelect contact: CNContact) {
    print("[", contact.identifier, "]", contact.givenName, contact.familyName)
//    _ = fetchName(contact.identifier)
  }
  
  func getAll(_ completion: @escaping ([CNContact]?)->Void ){
    requestContactAccess{ isAllowed in
      if isAllowed {
        let store = CNContactStore()
    
        let keysToFetch = [CNContactFormatter.descriptorForRequiredKeys(for: .fullName)]
        var allContainers = [CNContainer]()
        var results = [CNContact]()
    
        do {
          allContainers = try store.containers(matching: nil)
        } catch {
          print ("Error fetching contact containers")
          completion(nil)
          return
        }
    
        for container in allContainers {
          let fetchPredicate = CNContact.predicateForContactsInContainer(withIdentifier: container.identifier)
          do {
            let containerResults = try store.unifiedContacts(matching: fetchPredicate, keysToFetch: keysToFetch)
            results.append(contentsOf: containerResults)
          } catch {
            print("Error fetching contact results from container [\(container.identifier)]")
          }
        }
        
        completion(results)
      } else {
        print("Not allowed to have contact access")
        completion(nil)
      }
    }
  }
  
}