//
//  ItemListDataProvider.swift
//  ToDo
//
//  Created by Atthachai  on 7/17/17.
//

import UIKit

enum Section: Int {
  case todo
  case done
}

class ItemListDataProvider: NSObject, UITableViewDataSource, UITableViewDelegate {
  var itemManager: ItemManager?
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return 2
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    guard let itemManager = itemManager else { return 0 }
    guard let itemSection = Section(rawValue: section) else {
      fatalError()
    }
    
    let numberOfRows: Int
    
    switch itemSection {
    case .todo:
      numberOfRows = itemManager.toDoCount
    case .done:
      numberOfRows = itemManager.doneCount
    }
    return numberOfRows
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath) as! ItemCell
    if let item = itemManager?.itemAt(index: indexPath.row) {
      cell.configCell(with: item)
    }
    return cell
  }
  

}
