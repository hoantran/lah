//
//  BillableDataSource.swift
//  LendAHand
//
//  Created by Hoan Tran on 11/21/17.
//  Copyright © 2017 Hoan Tran. All rights reserved.
//

import UIKit

extension BillableViewController: UITableViewDataSource {
  public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if let works = self.works {
      return works.count
    } else {
      return 0
    }
  }
  public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: BillableCell.cellID, for: indexPath) as! BillableCell
    cell.work = self.works[indexPath.row]
    return cell
  }
}
