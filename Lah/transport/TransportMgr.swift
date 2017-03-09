//
//  TransportMgr.swift
//  Lah
//
//  Created by Hoan Tran on 2/22/17.
//  Copyright © 2017 Pego Consulting. All rights reserved.
//

import Foundation
import Firebase

extension Notification.Name {
    static let addProject       = Notification.Name("addProject")
    static let newProject       = Notification.Name("newProject")
    static let delProject       = Notification.Name("delProject")
    static let delProjectSvr    = Notification.Name("delProjectSvr")
    static let getProjects      = Notification.Name("getProjects")
}

class TransportMgr {
    var refProj : FIRDatabaseReference! = nil
    
    init() {
        refProj = FIRDatabase.database().reference(withPath: "projects")
        refProj.keepSynced(true)
        refProj.observe(.value, with: self.processProjects)
        refProj.observe(.childRemoved, with: {snapshot in
            print(snapshot)
            guard let prjModel = Project(snapshot: snapshot) else { return }
            NotificationCenter.default.post(name: .delProjectSvr, object: nil, userInfo: ["delProjectSvr":prjModel])
        })
        
        NotificationCenter.default.addObserver(forName: .addProject, object: nil, queue: nil, using: {notif in
            guard let prj = notif.userInfo?.first?.value as? Project else { return }
            let key = self.refProj.childByAutoId().key
            self.refProj.updateChildValues([key:prj.toAnyObject()])
        })
        NotificationCenter.default.addObserver(forName: .delProject, object: nil, queue: nil, using: {notif in
            guard let prj = notif.userInfo?.first?.value as? Project else { return }
            if let ref = prj.ref {
                ref.removeValue()
            }
        })
        NotificationCenter.default.addObserver(forName: .getProjects, object: nil, queue: nil, using: {_ in
            self.refProj.queryOrderedByKey().observeSingleEvent(of: .value, with: self.processProjects)
        })

    }
    
    func processProjects(snapshot: FIRDataSnapshot) {
        var prjs: [Project] = []
        for prj in snapshot.children {
            guard let prjModel = Project(snapshot: prj as! FIRDataSnapshot) else { continue }
            prjs.append(prjModel)
            NotificationCenter.default.post(name: .newProject, object: nil, userInfo: ["newProject":prjModel])
        }
        print(prjs.count)
        print(prjs)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}
