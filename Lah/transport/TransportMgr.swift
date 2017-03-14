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
    static let editedWorker     = Notification.Name("editedWorker")
    static let newWorker        = Notification.Name("newWorker")
    static let delWorker        = Notification.Name("delWorker")
    static let delWorkerSvr     = Notification.Name("delWorkerSvr")
    static let getWorkers       = Notification.Name("getWorkers")
}

class TransportMgr {
    var refProj : FIRDatabaseReference! = nil
    var refWorker : FIRDatabaseReference! = nil
    
    init() {
        initProjRef()
        initWorkerRef()
        
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
        
        // worker
        NotificationCenter.default.addObserver(forName: .editedWorker, object: nil, queue: nil, using: {notif in
            guard let wkr = notif.userInfo?.first?.value as? Worker else { return }
            var key: String = ""
            if wkr.key == "" {
                key = self.refWorker.childByAutoId().key
            } else {
                key = wkr.key
            }
            self.refWorker.updateChildValues([key:wkr.toAnyObject()])
        })
        NotificationCenter.default.addObserver(forName: .delWorker, object: nil, queue: nil, using: {notif in
            guard let item = notif.userInfo?.first?.value as? Worker else { return }
            if let ref = item.ref {
                ref.removeValue()
            }
        })
        NotificationCenter.default.addObserver(forName: .getWorkers, object: nil, queue: nil, using: {_ in
            self.refWorker.queryOrderedByKey().observeSingleEvent(of: .value, with: self.processWorkers)
        })

    }
    
    func initProjRef() {
        refProj = FIRDatabase.database().reference(withPath: "project")
        refProj.keepSynced(true)
        refProj.observe(.value, with: self.processProjects)
        refProj.observe(.childRemoved, with: {snapshot in
            print(snapshot)
            guard let prjModel = Project(snapshot: snapshot) else { return }
            NotificationCenter.default.post(name: .delProjectSvr, object: nil, userInfo: ["delProjectSvr":prjModel])
        })
    }
    
    func initWorkerRef() {
        refWorker = FIRDatabase.database().reference(withPath: "worker")
        refWorker.keepSynced(true)
        refWorker.observe(.value, with: self.processWorkers)
        refWorker.observe(.childRemoved, with: {snapshot in
            print(snapshot)
            guard let itemModel = Project(snapshot: snapshot) else { return }
            NotificationCenter.default.post(name: .delWorkerSvr, object: nil, userInfo: ["delWorkerSvr":itemModel])
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
    
    func processWorkers(snapshot: FIRDataSnapshot) {
        var itemSet: [Worker] = []
        for item in snapshot.children {
            guard let itemModel = Worker(snapshot: item as! FIRDataSnapshot) else { continue }
            itemSet.append(itemModel)
            NotificationCenter.default.post(name: .newWorker, object: nil, userInfo: ["newWorker":itemModel])
        }
        print(itemSet.count)
        print(itemSet)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}
