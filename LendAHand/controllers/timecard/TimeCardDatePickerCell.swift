//
//  TimeCardDatePickerCell.swift
//  LendAHand
//
//  Created by Hoan Tran on 11/14/17.
//  Copyright © 2017 Hoan Tran. All rights reserved.
//

import UIKit



class TimeCardDatePickerCell: BaseCell {
  static let cellID = "TimeCardDatePickerCell"
  static var expandedHeight: CGFloat { get { return 200 } }
  static var defaultHeight:  CGFloat { get { return 45  } }
  var observingCount: Int = 0 // make sure it does not remove observer too many times
  var date: Date? {
    didSet {
      if let date = self.date {
        self.dateLabel.text = self.formatter.string(from: date)
        self.picker.date = date
      }
    }
  }
  var updateHandler: ((Date)->())?
  
  var title: String? {
    didSet {
      if let title = self.title {
        self.titleLabel.text = title
      }
    }
  }
  
  override func prepareForReuse() {
    super.prepareForReuse()
    self.date = nil
    self.title = nil
    self.updateHandler = nil
    print("PREPARE FOR REUSE")
  }
  
  let formatter: DateFormatter = {
    let f = DateFormatter()
    f.dateFormat = "MMM d, yyyy h:mm a"
    return f
  }()
  
  lazy var picker: UIDatePicker = {
    let p = UIDatePicker()
    p.timeZone = NSTimeZone.local
    p.backgroundColor = UIColor.white
    p.layer.cornerRadius = 5.0
//    p.layer.shadowOpacity = 0.1
    p.translatesAutoresizingMaskIntoConstraints = false
    p.datePickerMode = .dateAndTime
    p.addTarget(self, action: #selector(handleDatePickerChange), for: .valueChanged)
    p.isHidden = true
    return p
  }()
  
  let titleLabel: UILabel = {
    let label = UILabel()
    label.text = "Start and x long]"
    label.textAlignment = .left
    label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()

  let dateLabel: UILabel = {
    let label = UILabel()
    label.text = "[12/12/12 long"
    label.textAlignment = .right
    label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  override func setupViews() {
    addSubview(titleLabel)
    addSubview(dateLabel)
    addSubview(picker)
    
    NSLayoutConstraint.activate([
      titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8),
      titleLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 8),
      titleLabel.rightAnchor.constraint(lessThanOrEqualTo: dateLabel.leftAnchor),
      titleLabel.bottomAnchor.constraint(lessThanOrEqualTo: picker.topAnchor, constant: 0),
      ])
    
    NSLayoutConstraint.activate([
      dateLabel.topAnchor.constraint(equalTo: titleLabel.topAnchor),
      dateLabel.leftAnchor.constraint(lessThanOrEqualTo: titleLabel.rightAnchor, constant: 0),
      dateLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -8),
      dateLabel.bottomAnchor.constraint(equalTo: titleLabel.bottomAnchor),
      ])
    
    NSLayoutConstraint.activate([
      picker.topAnchor.constraint(lessThanOrEqualTo: dateLabel.bottomAnchor),
      picker.leftAnchor.constraint(equalTo: titleLabel.leftAnchor),
      picker.rightAnchor.constraint(equalTo: dateLabel.rightAnchor),
      picker.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
      ])
  }
  
  deinit {
    self.deinitCellObserver()
  }
}

extension TimeCardDatePickerCell: CellObserver {
  static let FRAME_KEY_PATH = "frame"
  
  func hideDatePickerIfNeeded() {
    picker.isHidden = frame.size.height < TimeCardDatePickerCell.expandedHeight
    if let date = self.date {
      DispatchQueue.main.async {
        self.dateLabel.text = self.formatter.string(from: date)
      }
    }
  }
  
  func observeChanges() {
    if self.observingCount < 1 {
      addObserver(self, forKeyPath: TimeCardDatePickerCell.FRAME_KEY_PATH, options: .new, context: nil)
    }
    self.observingCount += 1
    hideDatePickerIfNeeded()
  }
  
  func ignoreChanges() {
    if self.observingCount > 0 {
      removeObserver(self, forKeyPath: TimeCardDatePickerCell.FRAME_KEY_PATH)
      self.observingCount -= 1
    }
  }
  
  override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
    if keyPath == TimeCardDatePickerCell.FRAME_KEY_PATH {
      hideDatePickerIfNeeded()
    }
  }
  
  func deinitCellObserver() {
    self.ignoreChanges()
  }
}


extension TimeCardDatePickerCell {
  
  @objc func handleDatePickerChange(sender: UIDatePicker) {
    print("handle: ", self.formatter.string(from: sender.date))
    self.date = sender.date
    self.updateHandler?(sender.date)
  }
  
}






