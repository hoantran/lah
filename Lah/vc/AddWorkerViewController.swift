//
//  AddWorkerViewController.swift
//  Lah
//
//  Created by Hoan Tran on 3/9/17.
//  Copyright © 2017 Pego Consulting. All rights reserved.
//

import UIKit

protocol EditedWorkerDelegate {
    func setWorker(_ worker: Worker)
}

class AddWorkerViewController: UITableViewController {
    @IBOutlet weak var rate: UITextField!
    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var phone: UITextField!
    @IBOutlet weak var email: UITextField!
    
    @IBOutlet weak var saveItem: UIBarButtonItem!
    
    var worker: Worker? = nil
    var editedWorkerDelegate: EditedWorkerDelegate?
    
    var rateDelegate = CurrencyTextFieldDelegate()
    

    var isValidated: Bool {
        // rate
        guard let rate = self.rate.text else { return false }
        if rate.isEmpty { return false }
        
        // first name
        guard let firstName = self.firstName.text else { return false }
        if firstName.isEmpty { return false }

        // last name
        guard let lastName = self.lastName.text else { return false }
        if lastName.isEmpty { return false }

        // phone
        guard let phone = self.phone.text else { return false }
        if phone.isEmpty { return false }
        if !WorkerFieldValidations.isPhoneNumber(phone) { return false }
        
        // email
        guard let email = self.email.text else { return false }
        if email.isEmpty { return false }
        if !WorkerFieldValidations.isEmail(email) { return false }
        
        return true
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        if let worker = self.worker {
            self.rate.text = String(worker.rate)
            self.firstName.text = worker.firstName
            self.lastName.text = worker.lastName
            self.phone.text = worker.phone
            self.email.text = worker.email
            navigationItem.title = "Edit Worker"
        }
        
        self.rate.delegate = rateDelegate
        self.saveItem.isEnabled = self.isValidated
        
        self.rate.addTarget(self, action: #selector(checkSaveEnability(_:)), for: .editingChanged)
        self.firstName.addTarget(self, action: #selector(checkSaveEnability(_:)), for: .editingChanged)
        self.lastName.addTarget(self, action: #selector(checkSaveEnability(_:)), for: .editingChanged)
        self.phone.addTarget(self, action: #selector(checkSaveEnability(_:)), for: .editingChanged)
        self.email.addTarget(self, action: #selector(checkSaveEnability(_:)), for: .editingChanged)
    }
    
    func checkSaveEnability(_ textField: UITextField) {
        self.saveItem.isEnabled = self.isValidated
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func save(_ sender: Any) {
        var key: String? = ""
        if self.worker != nil && self.worker?.key != "" {
            key = self.worker?.key
        }
        
        var rate: Float
        
        if var rateStr = self.rate.text {
            if rateStr.characters.first == "$" {
                rateStr.remove(at: rateStr.startIndex)
            }
            rate = Float(rateStr)!
        } else {
            rate = 0.00
        }
        
        let wkr = Worker(firstName: self.firstName.text, lastName: self.lastName.text, phone: self.phone.text, email: self.email.text, rate: rate, key: key!)
        
        NotificationCenter.default.post(name: .editedWorker, object: nil, userInfo: ["editedWorker":wkr as Any])
        if let delegate = self.editedWorkerDelegate {
            delegate.setWorker(wkr!)
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
