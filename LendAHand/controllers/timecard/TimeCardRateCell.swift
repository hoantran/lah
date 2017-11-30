//
//  TimeCardRateCell.swift
//  LendAHand
//
//  Created by Hoan Tran on 11/14/17.
//  Copyright © 2017 Hoan Tran. All rights reserved.
//

import UIKit

class TimeCardRateCell: BaseCell {
  static let cellID = "TimeCardRateCell"
  
  var updateHandler: ((Float)->())?
  
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
//    field.becomeFirstResponder()
    field.font = UIFont.systemFont(ofSize: 18, weight: .thin)
    field.textAlignment = .right
    field.autocorrectionType = .no
    field.delegate = self
    field.addTarget(self, action: #selector(rateDidChange), for: .editingChanged)
    return field
  } ()
  
  func getRate()->Float {
    if var rateStr = self.rate.text {
      if rateStr.first == "$" {
        rateStr.remove(at: rateStr.startIndex)
      }
      if let rate = Float(rateStr) {
        return rate
      }
    }
    
    return 0.00
  }
  
  override func setupViews() {
    
    addSubview(rateLabel)
    addSubview(rate)
    
    NSLayoutConstraint.activate([
      rateLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
      rateLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: Constants.margin.left),
      rateLabel.widthAnchor.constraint(equalToConstant: 110),
      rateLabel.heightAnchor.constraint(equalTo: heightAnchor),
      ])
    
    NSLayoutConstraint.activate([
      rate.centerYAnchor.constraint(equalTo: centerYAnchor),
      rate.leftAnchor.constraint(equalTo: rateLabel.rightAnchor, constant: 4),
      rate.rightAnchor.constraint(equalTo: rightAnchor, constant: -Constants.margin.right),
      rate.heightAnchor.constraint(equalTo: heightAnchor),
      ])
    
    didSelectHandler = didSelectRow
  }
}


extension TimeCardRateCell: UITextFieldDelegate {
  func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
    return textField.shouldChangeCharactersInRateField(textField, shouldChangeCharactersIn: range, replacementString: string)
  }
  
  func textFieldDidEndEditing(_ textField: UITextField) {
    self.updateHandler?(getRate())
  }
  
  func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
    rate.keyboardType = .decimalPad
    return true
  }
  
  @objc func rateDidChange(){
    self.updateHandler?(getRate())
  }
}

extension TimeCardRateCell {
  func didSelectRow() {
    rate.becomeFirstResponder()
  }
}





