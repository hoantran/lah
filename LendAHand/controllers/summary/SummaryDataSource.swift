//
//  SummaryDataSource.swift
//  LendAHand
//
//  Created by Hoan Tran on 12/1/17.
//  Copyright © 2017 Hoan Tran. All rights reserved.
//

import UIKit

extension SummaryViewController: UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if let count = self.works?.count {
      return count
    } else {
      return 0
    }
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: SummaryCell.cellID, for: indexPath) as! SummaryCell
    cell.textLabel?.text = self.works?[indexPath.row].project
    return cell
  }
}
