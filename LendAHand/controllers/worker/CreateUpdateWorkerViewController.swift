//
//  CreateUpdateWorkerViewController.swift
//  LendAHand
//
//  Created by Hoan Tran on 11/27/17.
//  Copyright © 2017 Hoan Tran. All rights reserved.
//

import UIKit
import Contacts

protocol WorkerDelegate: class {
  func observeNewWorker(_ worker: Worker)
}

class CreateUpdateWorkerViewController: UIViewController {
  
  var contact:CNContact? {
    didSet {
      if let contact = self.contact {
        if contact.givenName.count == 0 {
          name.text = contact.familyName
        } else {
          name.text = contact.givenName + " " + contact.familyName
        }
      }
    }
  }
  
  weak var workerDelegate: WorkerDelegate?
  weak var workerDataSourceDelegate: WorkerDataSourceDelegate?
  var isCreateNewWorker = true {
    didSet {
      name.isUserInteractionEnabled = self.isCreateNewWorker
    }
  }
  
  var heading: String? {
    didSet {
      DispatchQueue.main.async {
        self.navigationItem.title = self.heading
      }
    }
  }
  
  var initialRate: Float? {
    didSet {
      if let initialRate = self.initialRate {
        rate.text = initialRate.roundedTo(places: 2)
      }
    }
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    
    navigationItem.largeTitleDisplayMode = .never
//    navigationItem.title = "Create New Worker"
    view.backgroundColor = UIColor(hex: "0Xefefef")
    
    setupSaveButton()
    setupContainers()
  }
  
  var nameContainter:UIView = {
    let v = UIView()
    v.backgroundColor = UIColor.white
    v.translatesAutoresizingMaskIntoConstraints = false
    return v
  }()
  
  let nameLabel: UILabel = {
    let label = UILabel()
    label.text = "NAME"
    label.textAlignment = .left
    label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  lazy var name: UILabel = {
    let label = UILabel()
    label.text = "click for contacts"
    label.textAlignment = .right
    label.font = UIFont.systemFont(ofSize: 18, weight: .light)
    label.translatesAutoresizingMaskIntoConstraints = false
    
    let gesture = UITapGestureRecognizer(target: self, action: #selector(handleNameTap))
    gesture.numberOfTapsRequired = 1
    label.isUserInteractionEnabled = true
    label.addGestureRecognizer(gesture)
    return label
  }()
  
  @objc func handleNameTap() {
    print("handle Name Tap")
    let controller = ContactsViewController()
    let cancelBtn = UIBarButtonItem(title: "Cancel", style: .plain, target: nil, action: nil)
    navigationItem.backBarButtonItem = cancelBtn
    controller.selectDelegate = self
    navigationController?.pushViewController(controller, animated: true)
  }
  
  var rateContainter:UIView = {
    let v = UIView()
    v.backgroundColor = UIColor.white
    v.translatesAutoresizingMaskIntoConstraints = false
    return v
  }()
  
  let rateLabel: UILabel = {
    let label = UILabel()
    label.text = "RATE ($/hr)"
    label.textAlignment = .left
    label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  lazy var rate: UITextField = {
    let field = UITextField()
    field.placeholder = "0.00"
    field.translatesAutoresizingMaskIntoConstraints = false
    field.addTarget(self, action: #selector(handleRateTextChange), for: .editingChanged)
    //    field.becomeFirstResponder()
    field.font = UIFont.systemFont(ofSize: 18, weight: .thin)
    field.textAlignment = .right
    field.autocorrectionType = .no
    field.keyboardType = .decimalPad
    field.delegate = self
    return field
  } ()
  
  @objc func handleRateTextChange() {
    checkSavability()
  }

  fileprivate func setupContainers() {
    view.addSubview(nameContainter)
    view.addSubview(rateContainter)
    
    NSLayoutConstraint.activate([
      nameContainter.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
      nameContainter.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
      nameContainter.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Constants.margin.top),
      nameContainter.heightAnchor.constraint(equalToConstant: 30)
      ])
    
    nameContainter.addSubview(nameLabel)
    nameContainter.addSubview(name)
    
    NSLayoutConstraint.activate([
      nameLabel.centerYAnchor.constraint(equalTo: nameContainter.centerYAnchor),
      nameLabel.leftAnchor.constraint(equalTo: nameContainter.leftAnchor, constant: Constants.margin.left),
      nameLabel.rightAnchor.constraint(lessThanOrEqualTo: name.leftAnchor),
      nameLabel.heightAnchor.constraint(lessThanOrEqualTo: nameContainter.heightAnchor),
      ])
    
    NSLayoutConstraint.activate([
      name.centerYAnchor.constraint(equalTo: nameLabel.centerYAnchor),
      name.leftAnchor.constraint(lessThanOrEqualTo: nameLabel.rightAnchor, constant: 0),
      name.rightAnchor.constraint(equalTo: nameContainter.rightAnchor, constant: -Constants.margin.right),
      name.heightAnchor.constraint(equalTo: nameLabel.heightAnchor),
      ])
    

    
    NSLayoutConstraint.activate([
      rateContainter.topAnchor.constraint(equalTo: nameContainter.bottomAnchor, constant: 10),
      rateContainter.centerXAnchor.constraint(equalTo: nameContainter.centerXAnchor),
      rateContainter.widthAnchor.constraint(equalTo: nameContainter.widthAnchor),
      rateContainter.heightAnchor.constraint(equalTo: nameContainter.heightAnchor)
      ])
    
    rateContainter.addSubview(rateLabel)
    rateContainter.addSubview(rate)
    
    NSLayoutConstraint.activate([
      rateLabel.centerYAnchor.constraint(equalTo: rateContainter.centerYAnchor),
      rateLabel.leftAnchor.constraint(equalTo: rateContainter.leftAnchor, constant: Constants.margin.left),
      rateLabel.widthAnchor.constraint(equalToConstant: 110),
      rateLabel.heightAnchor.constraint(equalTo: rateContainter.heightAnchor),
      ])
    
    NSLayoutConstraint.activate([
      rate.centerYAnchor.constraint(equalTo: rateContainter.centerYAnchor),
      rate.leftAnchor.constraint(equalTo: rateLabel.rightAnchor, constant: 4),
      rate.rightAnchor.constraint(equalTo: rateContainter.rightAnchor, constant: -Constants.margin.right),
      rate.heightAnchor.constraint(equalTo: rateContainter.heightAnchor),
      ])
  }
  
  
  fileprivate func setupSaveButton() {
    let saveButton = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(handleSave))
    navigationItem.rightBarButtonItem = saveButton
    navigationItem.rightBarButtonItem?.isEnabled = false
  }
  
  @objc func handleSave() {
    print("handleSave")
    if  let rateText = rate.text,
      let contact = self.contact {
      if let rate = Float(rateText) {
        let newWorker = Worker(contact: contact.identifier, rate: rate)
        workerDelegate?.observeNewWorker(newWorker)
      }
    }

    navigationController?.popViewController(animated: true)
  }
}

extension CreateUpdateWorkerViewController: ContactSelectionDelegate {
  func selectContact(_ contact: CNContact) {
    self.contact = contact
    checkSavability()
  }
  
  fileprivate func checkSavability() {
    if let rate = rate.text {
      if self.isCreateNewWorker {
        if let identifier = self.contact?.identifier,
          let delegate = workerDataSourceDelegate {
          let worker = Worker(contact: identifier, rate: 0.0)
          navigationItem.rightBarButtonItem?.isEnabled =
            rate.count > 0 &&
            self.contact != nil &&
            !delegate.exists(worker)
        }
      } else {
        navigationItem.rightBarButtonItem?.isEnabled = rate.count > 0
      }
    }
    
    
//    if  let rate = rate.text,
//      let delegate = workerDataSourceDelegate,
//      let identifier = self.worker?.identifier
//    {
//      let worker = Worker(contact: identifier, rate: 0.0)
//      navigationItem.rightBarButtonItem?.isEnabled =
//        rate.count > 0 &&
//        self.worker != nil &&
//        !delegate.exists(worker)
//    }
  }
}


extension CreateUpdateWorkerViewController: UITextFieldDelegate {
  func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
    return textField.shouldChangeCharactersInRateField(textField, shouldChangeCharactersIn: range, replacementString: string)
  }
}

