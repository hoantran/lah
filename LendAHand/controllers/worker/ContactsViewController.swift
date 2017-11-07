//
//  ContactsViewController.swift
//  LendAHand
//
//  Created by Hoan Tran on 11/6/17.
//  Copyright © 2017 Hoan Tran. All rights reserved.
//

import UIKit
import Contacts
import ContactsUI

protocol ContactSelectionDelegate {
  func selectContact(_ contact: CNContact)
}

class ContactsViewController: UITableViewController, CNContactViewControllerDelegate {
  static let cellID = "ContactCellID"
  var selectDelegate: ContactSelectionDelegate?
  
  var contacts: [CNContact] = [] {
    didSet {
      DispatchQueue.main.async {
        self.tableView.reloadData()
      }
    }
  }
  
  @objc func handleAddTap() {
    let con = CNContact()
    let vc = CNContactViewController(forNewContact: con)
    vc.delegate = self
    _ = self.navigationController?.pushViewController(vc, animated: true)
  }
  
  func contactViewController(_ viewController: CNContactViewController, didCompleteWith contact: CNContact?) {
    if let contact = contact {
      passUpContact(contact)
    }
    navigationController?.popViewController(animated: true)
  }
  
  func passUpContact(_ contact: CNContact) {
    selectDelegate?.selectContact(contact)
    navigationController?.popViewController(animated: true)
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.contacts.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: ContactsViewController.cellID, for: indexPath)
    let contact = self.contacts[indexPath.row]
    let formatter = CNContactFormatter()
    
    cell.textLabel?.text = formatter.string(from: contact)
    return cell
  }
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let contact = self.contacts[indexPath.row]
    passUpContact(contact)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = Constants.color.bkg
    
    navigationItem.title = "Contacts"
    navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(handleAddTap))
    
    tableView.register(UITableViewCell.self, forCellReuseIdentifier: ContactsViewController.cellID)
    
    ContactMgr.shared.getAll() { contacts in
      if let contacts = contacts {
        self.contacts = contacts
      } else {
        print("no contact was found")
      }
    }
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
}


