//
//  AddProjectViewController.swift
//  Lah
//
//  Created by Hoan Tran on 2/16/17.
//  Copyright © 2017 Pego Consulting. All rights reserved.
//

import UIKit

class AddProjectViewController: UITableViewController, UITextFieldDelegate {
    @IBOutlet weak var project: UITextField!
    @IBOutlet weak var saveItem: UIBarButtonItem!

    var tableViewDelegate: AddProjectTableViewDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableViewDelegate = AddProjectTableViewDelegate(tableView: tableView)
        self.saveItem.action = #selector(self.save)
        
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.project.becomeFirstResponder()
        self.saveItem.isEnabled = false
    }
    
    

    // MARK: - Table view data source
    @IBAction func cancel() {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func save() {
        let addProject = Project(name: self.project.text, isCompleted: false)
        if addProject != nil {
            NotificationCenter.default.post(Notification(name: .addProject, object: self, userInfo: ["addProject":addProject as Any]))
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let oldText = textField.text! as NSString
        let newText = oldText.replacingCharacters(in: range, with: string) as NSString
        self.saveItem.isEnabled = (newText.length > 0)
        return true
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
