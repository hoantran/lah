//
//  AddNewWorkertViewController.swift
//  LendAHand
//
//  Created by Hoan Tran on 11/6/17.
//  Copyright © 2017 Hoan Tran. All rights reserved.
//

import UIKit
import Contacts

protocol NewWorkerDelegate: class {
  func observeNewWorker(_ worker: Worker)
}

class AddNewWorkertViewController: UIViewController, ContactSelectionDelegate {
  
  var worker:CNContact? {
    didSet {
      if let contact = self.worker {
        let formatter = CNContactFormatter()
        name.setTitle(formatter.string(from: contact), for: .normal)
      }
    }
  }
  
  weak var workerDelegate: NewWorkerDelegate?
  weak var workerDataSourceDelegate: WorkerDataSourceDelegate?
  
  var name:UIButton = {
    let b = UIButton()
    b.translatesAutoresizingMaskIntoConstraints = false
    b.setTitle("Name", for: .normal)
    b.setTitleColor(UIColor.black, for: .normal)
    b.addTarget(self, action: #selector(handleNameTap), for: .touchUpInside)
    b.contentHorizontalAlignment = .left
    return b
  }()
  
  fileprivate func setupName() {
    view.addSubview(name)
    NSLayoutConstraint.activate([
      name.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      name.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 8),
      name.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -8),
      name.heightAnchor.constraint(equalToConstant: 25)
      ])
  }
  
  @objc func handleNameTap() {
    let controller = ContactsViewController()
    let cancelBtn = UIBarButtonItem(title: "Cancel", style: .plain, target: nil, action: nil)
    navigationItem.backBarButtonItem = cancelBtn
    controller.selectDelegate = self
    navigationController?.pushViewController(controller, animated: true)
    
//    show(controller, sender: self)
//    present(UINavigationController(rootViewController: controller)  , animated: true, completion: nil)
//    present(controller  , animated: true, completion: nil)
  }
  
  func selectContact(_ contact: CNContact) {
    self.worker = contact
    checkSavability()
  }
  
  var rateUnitLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.text = "$/hr"
    label.font = UIFont.systemFont(ofSize: 18, weight: .ultraLight)
    label.textColor = UIColor.lightGray
    return label
  }()
  
  fileprivate func setupRateUnitLabel() {
    view.addSubview(rateUnitLabel)
    NSLayoutConstraint.activate([
      rateUnitLabel.topAnchor.constraint(equalTo: name.bottomAnchor, constant: 10),
      rateUnitLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -8),
      rateUnitLabel.widthAnchor.constraint(equalToConstant: 40),
      rateUnitLabel.heightAnchor.constraint(equalToConstant: 25)
      ])
  }
  
  lazy var rateDelegate:CurrencyTextFieldDelegate = {
    let delegate =  CurrencyTextFieldDelegate()
    return delegate
  }()
  
  let rate: UITextField = {
    let field = UITextField()
    field.placeholder = "rate"
    field.translatesAutoresizingMaskIntoConstraints = false
    field.addTarget(self, action: #selector(handleRateTextChange), for: .editingChanged)
    field.becomeFirstResponder()
    field.font = UIFont.systemFont(ofSize: 18, weight: .thin)
    field.autocorrectionType = .no
    return field
  } ()
  
  fileprivate func setupRate() {
    view.addSubview(rate)
    NSLayoutConstraint.activate([
      rate.centerYAnchor.constraint(equalTo: rateUnitLabel.centerYAnchor),
      rate.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 8),
      rate.rightAnchor.constraint(equalTo: rateUnitLabel.leftAnchor, constant: -8),
      rate.heightAnchor.constraint(equalTo: rateUnitLabel.heightAnchor)
      ])
  }
  
  @objc func handleRateTextChange() {
    checkSavability()
  }
  
  fileprivate func checkSavability() {
    if  let rate = rate.text,
        let delegate = workerDataSourceDelegate,
        let identifier = self.worker?.identifier
    {
      let worker = Worker(contact: identifier, rate: 0.0)
      navigationItem.rightBarButtonItem?.isEnabled =
        rate.count > 0 &&
        self.worker != nil &&
        !delegate.exists(worker)
    }
  }

  fileprivate func setupSaveButton() {
    let saveButton = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(handleSave))
    navigationItem.rightBarButtonItem = saveButton
    navigationItem.rightBarButtonItem?.isEnabled = false
    //    let prjNameValidator = ProjectNameValidation()
    //    prjNameValidator.barItem = saveButton
    //    name.delegate = prjNameValidator
  }
  
  @objc func handleSave() {
    if  let rateText = rate.text,
        let worker = worker {
      if let rate = Float(rateText) {
          let newWorker = Worker(contact: worker.identifier, rate: rate)
          workerDelegate?.observeNewWorker(newWorker)
      }
    }
    
    navigationController?.popViewController(animated: true)
  }
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = Constants.color.bkg
    navigationItem.title = "New Worker"
    setupSaveButton()
    setupName()
    setupRateUnitLabel()
    setupRate()
    rate.delegate = rateDelegate
//    print("--- INIT ---")
  }
  
  deinit {
//    print("--- DEINIT ---")
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  
  
}
