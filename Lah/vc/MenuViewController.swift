//
//  MenuViewController.swift
//  Lah
//
//  Created by Hoan Tran on 3/17/17.
//  Copyright © 2017 Pego Consulting. All rights reserved.
//

import UIKit

extension Notification.Name {
    static let workersSelected = Notification.Name("workersSelected")
    static let projectsSelected = Notification.Name("projectsSelected")
}


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
            MenuDefintion(title: "Workers", image: UIImage(named: "tedy_bear_128px.png"), notif: .workerSelected),
            MenuDefintion(title: "Projects", image: UIImage(named: "lamp-2_128px.png"), notif: .projectsSelected)
        ]
    }
}

protocol MenuData {}

extension MenuData {
    var definitions: [MenuDefintion] {
        get {
            return MenuDefintion.definitions
        }
    }
}

class MenuViewController: UIViewController, MenuData, UITableViewDataSource, UITableViewDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.definitions.count
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MenuCell.MenuCellID, for: indexPath) as! MenuCell
        let def = self.definitions[indexPath.row]
        cell.config(title: def.title, icon: def.image)
        return cell
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let def = self.definitions[indexPath.row]
        let center = NotificationCenter.default

        center.post(name: def.notif, object: nil)
        center.post(name: .vcSelected, object: nil)
        
        print("selected \(indexPath.row)")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}


class MenuCell: UITableViewCell {
    static let MenuCellID = "MenuCellID"

    @IBOutlet weak var vc: UILabel!
    @IBOutlet weak var icon: UIImageView!
    
    func config(title: String, icon: UIImage?) {
        self.vc.text = title
        self.icon.image = icon
    }
    
    // Makes "selectionColor" attribute in the Attributes Inspector for this cell definition
    // http://www.tekramer.com/changing-uitableviewcell-selection-color-in-storyboards-with-ibinspectable
    @IBInspectable var selectionColor: UIColor = .green {
        didSet {
            configureSelectedBackgroundView()
        }
    }
    
    func configureSelectedBackgroundView() {
        let view = UIView()
        view.backgroundColor = selectionColor
        selectedBackgroundView = view
    }
}




