//
//  MenuViewController.swift
//  LendAHand
//
//  Created by Hoan Tran on 10/31/17.
//  Copyright © 2017 Hoan Tran. All rights reserved.
//

import UIKit

struct MenuDefintion {
  let title: String
  let image: UIImage?
  let notif: Notification.Name
  
  init(title: String, image: UIImage?, notif: Notification.Name) {
    self.title = title
    self.image = image
    self.notif = notif
  }
  
  static var definitions: [MenuDefintion] {
    return [
      MenuDefintion(title: "Workers", image: UIImage(named: "tedy_bear_128px.png"), notif: .workersSelected),
      MenuDefintion(title: "Projects", image: UIImage(named: "lamp-2_128px.png"), notif: .projectsSelected),
      MenuDefintion(title: "Logout", image: UIImage(named: "lamp_128px.png"), notif: .logoutSelected)
    ]
  }
}


class MenuViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
  static let cellID = "cellID"
  
  lazy var table: UITableView = {
    let tableView = UITableView()
    tableView.translatesAutoresizingMaskIntoConstraints = false
    tableView.dataSource = self
    tableView.delegate = self
    tableView.separatorStyle = .none
    tableView.bounces = false
    return tableView
  }()
  
  var logo: UIImageView = {
    let imageView = UIImageView()
    imageView.image = UIImage(named: "palm")
    imageView.translatesAutoresizingMaskIntoConstraints = false
    return imageView
  } ()
  
  var name: UILabel = {
    let label = UILabel()
    label.text = "LEND A HAND"
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = Constants.baseColor
    navigationItem.title = "Menu"
    navigationController?.isNavigationBarHidden = true
    
    table.register(MenuCell.self, forCellReuseIdentifier: MenuCell.ID)
    setupHeader()
    setupTable()
  }
  
  fileprivate func getNavBarHeight()->CGFloat {
    if let height = self.navigationController?.navigationBar.frame.size.height {
      return height
    } else {
      return 64
    }
  }
  
  fileprivate func setupHeader() {
    view.addSubview(logo)
    NSLayoutConstraint.activate([
      logo.topAnchor.constraint(equalTo: view.topAnchor, constant: 30),
      logo.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 12),
      logo.widthAnchor.constraint(equalToConstant: 50),
      logo.heightAnchor.constraint(equalToConstant: 50)
      ])
    
    view.addSubview(name)
    NSLayoutConstraint.activate([
      name.leftAnchor.constraint(equalTo: logo.rightAnchor, constant: 8),
      name.centerYAnchor.constraint(equalTo: logo.centerYAnchor),
      name.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 8),
      name.heightAnchor.constraint(equalToConstant: 20)
      ])
  }
  
  fileprivate func setupTable() {
    view.addSubview(table)
    NSLayoutConstraint.activate([
      table.topAnchor.constraint(equalTo: logo.bottomAnchor, constant: 10),
      table.leftAnchor.constraint(equalTo: view.leftAnchor),
      table.rightAnchor.constraint(equalTo: view.rightAnchor),
      table.bottomAnchor.constraint(equalTo: view.bottomAnchor)
      ])
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return MenuDefintion.definitions.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: MenuCell.ID, for: indexPath) as! MenuCell
    cell.definition = MenuDefintion.definitions[indexPath.row]
    if indexPath.row == 2 {
    }
    return cell
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 60
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let def = MenuDefintion.definitions[indexPath.row]
    let center = NotificationCenter.default
    
    center.post(name: def.notif, object: nil)
    center.post(name: .vcSelected, object: nil)
  }
}

class MenuCell: UITableViewCell {
  static let ID = "MenuCell.id"
  
  lazy var thumbnailImage:UIImageView = {
    let imageView = UIImageView()
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.contentMode = .scaleAspectFill
    return imageView
  }()
  
  lazy var label: UILabel = {
    let labelView = UILabel()
    labelView.translatesAutoresizingMaskIntoConstraints = false
    return labelView
  }()
  
  var definition: MenuDefintion? {
    didSet {
      thumbnailImage.image = self.definition?.image
      label.text = self.definition?.title
      
      addSubview(thumbnailImage)
      NSLayoutConstraint.activate([
        thumbnailImage.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 12),
        thumbnailImage.centerYAnchor.constraint(equalTo: self.centerYAnchor),
        thumbnailImage.widthAnchor.constraint(equalToConstant: 50),
        thumbnailImage.heightAnchor.constraint(equalToConstant: 50)
        ])
      
      addSubview(label)
      NSLayoutConstraint.activate([
        label.leftAnchor.constraint(equalTo: thumbnailImage.rightAnchor, constant: 10),
        label.centerYAnchor.constraint(equalTo: thumbnailImage.centerYAnchor),
        label.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -8 ),
        label.heightAnchor.constraint(equalTo: thumbnailImage.heightAnchor)
        ])

    }
  }
  
  override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    configureSelectedBackgroundView()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) in MenuCell has not been implemented")
  }
  
  func configureSelectedBackgroundView() {
    let view = UIView()
    view.backgroundColor = Constants.highlightColor
    selectedBackgroundView = view
  }
  
}

