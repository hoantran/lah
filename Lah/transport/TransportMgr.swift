//
//  TransportMgr.swift
//  Lah
//
//  Created by Hoan Tran on 2/22/17.
//  Copyright © 2017 Pego Consulting. All rights reserved.
//

import Foundation

extension Notification.Name {
    static let addProject = Notification.Name("addProject")
    static let newProject = Notification.Name("newProject")
}

class TransportMgr {
    
    init() {
//        NotificationCenter.default.addObserver(self, selector: #selector(FirstViewController.updateNotificationSentLabel), name: NSNotification.Name(rawValue: mySpecialNotificationKey
//        NotificationCenter.default.addObserver(self, selector: #selector(self.addProject), name: .addProject, object: nil)
        NotificationCenter.default.addObserver(forName: .addProject, object: nil, queue: nil, using: {notif in
            guard let prj = notif.userInfo?.first?.value as? Project else { return }
            NotificationCenter.default.post(name: .newProject, object: nil, userInfo: ["newProject":prj])
        })
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}
