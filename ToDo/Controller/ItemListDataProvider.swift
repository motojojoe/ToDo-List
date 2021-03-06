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
    
    guard let itemManager = itemManager else {
      fatalError()
    }
    guard let section = Section(rawValue: indexPath.section) else {
      fatalError()
    }
    
    let item: ToDoItem
    switch section {
    case .todo:
      item = itemManager.itemAt(index: indexPath.row)
    case .done:
      item = itemManager.doneItemAt(index: indexPath.row)
    }
    
    cell.configCell(with: item)
    
    return cell
  }
  
  func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
    guard let section = Section(rawValue: indexPath.section) else {
      fatalError()
    }
    let buttonTitle: String
    switch section {
    case .todo:
      buttonTitle = "Check"
    case .done:
      buttonTitle = "Uncheck"
    }
    return buttonTitle
  }
  
  func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
    guard let itemManager = itemManager else {
      fatalError()
    }
    guard let section = Section(rawValue: indexPath.section) else {
      fatalError()
    }
    
    switch section {
    case .todo:
      itemManager.checkItemAt(index: indexPath.row)
    case .done:
      itemManager.uncheckItem(at: indexPath.row)
    }
    
    tableView.reloadData()
  }
}
