//
//  TimeCardNoteCell.swift
//  LendAHand
//
//  Created by Hoan Tran on 11/21/17.
//  Copyright © 2017 Hoan Tran. All rights reserved.
//

import UIKit

class TimeCardNoteCell: BaseCell, UITextViewDelegate {
  static let cellID = "TimeCardNoteCell"
  static let PLACE_HOLDER = "NOTE"
  static var height: CGFloat { get { return 100 } }
  
  var updateHandler: ((String)->())?
  
  var noteText: String? {
    didSet {
      if let noteText = self.noteText {
        if noteText.count > 0 {
          note.text = noteText
          note.textColor = UIColor.black
        }
      }
    }
  }
  
  lazy var note: UITextView = {
    let field = UITextView()
    field.text = TimeCardNoteCell.PLACE_HOLDER
    field.textColor = UIColor.lightGray
    field.translatesAutoresizingMaskIntoConstraints = false
    field.font = UIFont.systemFont(ofSize: 18, weight: .thin)
    field.textAlignment = .left
    field.autocorrectionType = .no
    field.delegate = self
    return field
  } ()
  
  override func prepareForReuse() {
    noteText = nil
    updateHandler = nil
  }
  
  func textViewDidBeginEditing(_ textView: UITextView) {
    if textView.textColor == UIColor.lightGray {
      textView.text = nil
      textView.textColor = UIColor.black
    }
  }
  
  func textViewDidEndEditing(_ textView: UITextView) {
    if textView.text.isEmpty {
      textView.text = TimeCardNoteCell.PLACE_HOLDER
      textView.textColor = UIColor.lightGray
    }
    if let text = textView.text,
      let handler = updateHandler{
      handler(text)
    }
  }
  
  override func setupViews() {
    addSubview(note)
    NSLayoutConstraint.activate([
      note.centerYAnchor.constraint(equalTo: centerYAnchor),
      note.leftAnchor.constraint(equalTo: leftAnchor, constant: Constants.margin.left-4),
      note.rightAnchor.constraint(equalTo: rightAnchor, constant: -Constants.margin.right),
      note.heightAnchor.constraint(equalTo: heightAnchor),
      ])
  }
}

