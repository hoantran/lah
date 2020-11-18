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
    v.layer.cornerRadius = 5
    v.layer.masksToBounds = true
    v.backgroundColor = UIColor.white
    return v
  }()
  
  lazy var name: UITextField = {
    let field = UITextField()
    field.placeholder = "Enter Project Name"
    field.translatesAutoresizingMaskIntoConstraints = false
    field.addTarget(self, action: #selector(handleTextChange), for: .editingChanged)
    field.becomeFirstResponder()
    field.autocorrectionType = .no
    field.textAlignment = .center
    field.font = UIFont.systemFont(ofSize: 22, weight: .thin)
    field.delegate = self
    return field
  } ()
  
  lazy var save: UIButton = {
    let b = UIButton()
    b.translatesAutoresizingMaskIntoConstraints = false
    b.setTitle("SAVE", for: .normal)
    b.backgroundColor = UIColor(hex: "0X5dff5b")
    b.setTitleColor(UIColor.white, for: .normal)
    b.addTarget(self, action: #selector(handleSave), for: .touchUpInside)
    b.titleLabel?.font = UIFont.boldSystemFont(ofSize: 24)
    b.contentHorizontalAlignment = .center
    b.layer.cornerRadius = 5
    b.layer.borderWidth = 1
    b.layer.borderColor = UIColor.clear.cgColor
    b.isEnabled = false
    return b
  }()
  
  fileprivate func updateSaveAlpha() {
    if save.isEnabled {
      save.alpha = 1.0
    } else {
      save.alpha = 0.3
    }
  }
  
  fileprivate func setupTextFields() {
    view.addSubview(inputsContainerView)
    view.addSubview(save)
    
    NSLayoutConstraint.activate([
      inputsContainerView.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor, constant: -115),
      inputsContainerView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
      inputsContainerView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
      inputsContainerView.heightAnchor.constraint(equalToConstant: 50)
      ])
    
    inputsContainerView.addSubview(name)
    NSLayoutConstraint.activate([
      name.centerYAnchor.constraint(equalTo: inputsContainerView.centerYAnchor),
      name.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor, constant: 8),
      name.rightAnchor.constraint(equalTo: inputsContainerView.rightAnchor, constant: -8),
      name.heightAnchor.constraint(equalToConstant: 25)
      ])
    
    NSLayoutConstraint.activate([
      save.centerXAnchor.constraint(equalTo: inputsContainerView.centerXAnchor),
      save.topAnchor.constraint(equalTo: inputsContainerView.bottomAnchor, constant: 25),
      save.heightAnchor.constraint(equalToConstant: 40),
      save.widthAnchor.constraint(equalToConstant: 170),
      ])
    
  }
  
  @objc func handleTextChange() {
    save.isEnabled = isSavable()
    updateSaveAlpha()
  }
  
  private func isSavable() -> Bool{
    if let text = name.text {
      return text.count > 0 && !text.trimmingCharacters(in: .whitespaces).isEmpty
    }
    return false
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = UIColor(hex: "0Xefefef")
    
    setupTextFields()
    updateSaveAlpha()
  }
  
  @objc func handleSave() {
    if let projectName = name.text {
      let project = Project(contact: nil, name: projectName, completed: false)
      projectDelegate?.observeCreateUpdateProject(project)
    }
    navigationController?.popViewController(animated: true)
  }
  
}

extension CreateUpdateProjectViewController: UITextFieldDelegate {
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    if isSavable() {
      name.resignFirstResponder()
      handleSave()
      return true
    } else {
      return false
    }
  }
}




