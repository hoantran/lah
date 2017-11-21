//
//  TimeCardDelegate.swift
//  LendAHand
//
//  Created by Hoan Tran on 11/13/17.
//  Copyright © 2017 Hoan Tran. All rights reserved.
//

// there are at least two ways to implement exapanding (UIDatePicker) cell:
// [1] by inserting just a brand new cell that only embeds a UIDatePicker when a row is selected.
//     this is well illustrated here: https://digitalleaves.com/blog/2017/01/dynamic-uidatepickers-in-a-table-view/
//     and here: http://blog.fujianjin6471.com/2016/02/03/how-to-implement-inline-date-picker.html
// [2] by expanding a cell that has both the label field(s) and a UIDatePicker just below it/them
//     and when this cell is clicked, the height of the cell changes to expose or cover up the date picker element.
//     like here: https://www.appcoda.com/expandable-table-view/
//     or here: https://github.com/rcdilorenzo/Cell-Expander
//     this is what is used in this code

import UIKit

extension TimeCardViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let prevIndexPath = self.selectedIndexPath
    
    if indexPath == self.selectedIndexPath {
      self.selectedIndexPath = nil
    } else {
      self.selectedIndexPath = indexPath
    }
    
    var indexPathArray: Array<IndexPath> = []
    
    if let current = self.selectedIndexPath {
      indexPathArray.append(current)
    }
    if let prev = prevIndexPath {
      indexPathArray.append(prev)
    }
    
    if indexPathArray.count > 0 {
      tableView.reloadRows(at: indexPathArray, with: .automatic)
    }
    
////    tableView.beginUpdates()
////    tableView.endUpdates()
  }
  
  func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    if let cell = cell as? CellObserver {
      cell.observeChanges()
    }
    
    // adding rounded corners
    // https://medium.com/@jigarm/corner-radius-to-uitableview-grouped-461817ca5dc
//    let cornerRadius: CGFloat = 8
//    cell.backgroundColor = .clear
//    
//    let layer = CAShapeLayer()
//    let pathRef = CGMutablePath()
//    let bounds = cell.bounds.insetBy(dx: 14, dy: 0)
//    var addLine = false
//    
//    if indexPath.row == 0 && indexPath.row == tableView.numberOfRows(inSection: indexPath.section) - 1 {
//      pathRef.__addRoundedRect(transform: nil, rect: bounds, cornerWidth: cornerRadius, cornerHeight: cornerRadius)
//    } else if indexPath.row == 0 {
//      pathRef.move(to: .init(x: bounds.minX, y: bounds.maxY))
//      pathRef.addArc(tangent1End: .init(x: bounds.minX, y: bounds.minY), tangent2End: .init(x: bounds.midX, y: bounds.minY), radius: cornerRadius)
//      pathRef.addArc(tangent1End: .init(x: bounds.maxX, y: bounds.minY), tangent2End: .init(x: bounds.maxX, y: bounds.midY), radius: cornerRadius)
//      pathRef.addLine(to: .init(x: bounds.maxX, y: bounds.maxY))
//      addLine = true
//    } else if indexPath.row == tableView.numberOfRows(inSection: indexPath.section) - 1 {
//      pathRef.move(to: .init(x: bounds.minX, y: bounds.minY))
//      pathRef.addArc(tangent1End: .init(x: bounds.minX, y: bounds.maxY), tangent2End: .init(x: bounds.midX, y: bounds.maxY), radius: cornerRadius)
//      pathRef.addArc(tangent1End: .init(x: bounds.maxX, y: bounds.maxY), tangent2End: .init(x: bounds.maxX, y: bounds.midY), radius: cornerRadius)
//      pathRef.addLine(to: .init(x: bounds.maxX, y: bounds.minY))
//    } else {
//      pathRef.addRect(bounds)
//      addLine = true
//    }
//    
//    layer.path = pathRef
//    layer.fillColor = UIColor(white: 1, alpha: 0.8).cgColor
//    
//    if (addLine == true) {
//      let lineLayer = CALayer()
//      let lineHeight = 1.0 / UIScreen.main.scale
//      lineLayer.frame = CGRect(x: bounds.minX + 10, y: bounds.size.height - lineHeight, width: bounds.size.width - 10, height: lineHeight)
//      lineLayer.backgroundColor = tableView.separatorColor?.cgColor
//      layer.addSublayer(lineLayer)
//    }
//    
//    let testView = UIView(frame: bounds)
//    testView.layer.insertSublayer(layer, at: 0)
//    testView.backgroundColor = .clear
//    cell.backgroundView = testView
    
  }
  
  func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    if let cell = cell as? CellObserver {
      cell.ignoreChanges()
    }
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    for visible in tableView.visibleCells {
      if let cell = visible as? CellObserver {
        cell.ignoreChanges()
      }
    }
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    if indexPath == self.selectedIndexPath {
      if indexPath.section == TimeCardArrangement.time.rawValue &&
        indexPath.row <= TimeCardArrangement.timeRow.stop.rawValue{
        return TimeCardDatePickerCell.expandedHeight
      }
    }
    
    if indexPath.section == TimeCardArrangement.note.rawValue {
      return TimeCardNoteCell.height
    }
    
    return TimeCardDatePickerCell.defaultHeight
  }
  
  func reloadDuration() {
    let indexPath = IndexPath(item: TimeCardArrangement.timeRow.duration.hashValue, section: TimeCardArrangement.time.hashValue)
    tableView.reloadRows(at: [indexPath], with: .automatic)
  }
}
