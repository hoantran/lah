//
//  TimeCardViewController.swift
//  Lah
//
//  Created by Hoan Tran on 3/15/17.
//  Copyright © 2017 Pego Consulting. All rights reserved.
//

import UIKit

class TimeCardViewController: UIViewController, EditedWorkerDelegate {
    var worker: Worker?
    static let TimeCardSegue = "EditWorker"
    var billables: [Billable] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        guard let worker = self.worker, let lastName = self.worker?.lastName else { return }
        self.navigationItem.title = "\(worker.firstName) \(lastName)"
        createFakeBillables()
    }
    
    func createFakeBillables() {
        guard let workerKey = self.worker?.key else { return }
        let time = Int(CFAbsoluteTimeGetCurrent())
        let backtrack = 3 * 30 * 24 * 60 * 60 // about 3 months
        let maxDuration = 24 * 60 * 60 // 1 day
        for _ in 0...9 {
            let start = Int.random(min: (time-backtrack), max: time)
            let end = time + Int.random(min: 3600, max: maxDuration)
            self.billables.append(Billable(rate: Float.random(min: 9.50, max: 15.87).roundTo(places: 2),
                                           start: start,
                                           end: end,
                                           project: "-Kf_n1c1uH3Jf0abIdku",
                                           worker: workerKey,
                                           paid: end + 120,
                                           note: "Hella job!" ))
        }
        
        print(self.billables)
    }
    
    @IBAction func cancel(_ sender: Any) {
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func edit(_ sender: Any) {
        performSegue(withIdentifier: TimeCardViewController.TimeCardSegue, sender: self)
    }
    
    func setWorker(_ worker: Worker) {
        self.worker = worker
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == TimeCardViewController.TimeCardSegue {
            let upcoming: AddWorkerViewController = (( segue.destination ) as! UINavigationController).topViewController as! AddWorkerViewController
            upcoming.editedWorkerDelegate = self
            upcoming.worker = worker
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
