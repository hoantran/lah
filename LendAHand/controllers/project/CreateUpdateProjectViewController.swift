//
//  CreateUpdateProjectViewController.swift
//  LendAHand
//
//  Created by Hoan Tran on 11/2/17.
//  Copyright © 2017 Hoan Tran. All rights reserved.
//

import UIKit

protocol CreateUpdateProjectDelegate: NSObjectProtocol {
  func observeCreateUpdateProject(_ prj: Project)
}

class CreateUpdateProjectViewController: UIViewController {
  weak var projectDelegate: CreateUpdateProjectDelegate?
  var heading: String? {
    didSet {
      DispatchQueue.main.async {
        self.navigationItem.title = self.heading
      }
    }
  }
  
  var projectName: String? {
    didSet {
      DispatchQueue.main.async {
        self.name.text = self.projectName
      }
    }
  }
  
  let inputsContainerView: UIView = {
    let v = UIView()
    v.translatesAutoresizingMaskIntoConstraints = false
    v.backgroundColor = Constants.color.fieldBkg
    v.layer.cornerRadius = 5
    v.layer.masksToBounds = true
    return v
  }()
  
  let name: UITextField = {
    let field = UITextField()
    field.placeholder = "Enter Project Name"
    field.translatesAutoresizingMaskIntoConstraints = false
    field.addTarget(self, action: #selector(handleTextChange), for: .editingChanged)
    field.becomeFirstResponder()
    field.autocorrectionType = .no
    return field
  } ()
  
  fileprivate func setupSaveButton() {
    let saveButton = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(handleSave))
    navigationItem.rightBarButtonItem = saveButton
    navigationItem.rightBarButtonItem?.isEnabled = false
  }
  
  fileprivate func setupTextFields() {
    view.addSubview(inputsContainerView)
    NSLayoutConstraint.activate([
      inputsContainerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
      inputsContainerView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 8),
      inputsContainerView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -8),
      inputsContainerView.heightAnchor.constraint(equalToConstant: 50)
      ])
    
    inputsContainerView.addSubview(name)
    NSLayoutConstraint.activate([
      name.centerYAnchor.constraint(equalTo: inputsContainerView.centerYAnchor),
      name.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor, constant: 8),
      name.rightAnchor.constraint(equalTo: inputsContainerView.rightAnchor, constant: -8),
      name.heightAnchor.constraint(equalToConstant: 25)
      ])
    
  }
  
  @objc func handleTextChange() {
    if let text = name.text {
      navigationItem.rightBarButtonItem?.isEnabled = text.count > 0
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupSaveButton()
    
    view.backgroundColor = Constants.color.bkg
    setupTextFields()
    
//    print("--- INIT ---")
  }
  
  @objc func handleSave() {
    if let projectName = name.text {
      let project = Project(contact: nil, name: projectName, completed: false)
      projectDelegate?.observeCreateUpdateProject(project)
    }
    navigationController?.popViewController(animated: true)
  }
  
  deinit {
//    print("--- DEINIT ---")
  }
  
}
