//
//  AddNewProjectViewController.swift
//  LendAHand
//
//  Created by Hoan Tran on 11/2/17.
//  Copyright © 2017 Hoan Tran. All rights reserved.
//

import UIKit

protocol NewProjectDelegate {
  func observeNewProject(_ prj: Project)
}

class AddNewProjectViewController: UIViewController {
  var projectDelegate: NewProjectDelegate?
  
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
    field.placeholder = "name"
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
//    let prjNameValidator = ProjectNameValidation()
//    prjNameValidator.barItem = saveButton
//    name.delegate = prjNameValidator
  }
  
  fileprivate func setupTextFields() {
    view.addSubview(inputsContainerView)
    NSLayoutConstraint.activate([
      inputsContainerView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
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
    navigationItem.title = "New Project"
    setupSaveButton()
    
    view.backgroundColor = Constants.color.bkg
    setupTextFields()
  }
  
  @objc func handleSave() {
    if let projectName = name.text {
      let project = Project(contact: nil, name: projectName, completed: false)
      projectDelegate?.observeNewProject(project)
    }
    navigationController?.popViewController(animated: true)
  }
  
}
