//
//  ItemManager.swift
//  ToDo
//
//  Created by Atthachai  on 7/12/17.
//

import Foundation

class ItemManager {
  var toDoCount: Int { return toDoItems.count }
  var doneCount: Int { return doneItems.count }
  private var toDoItems: [ToDoItem] = []
  private var doneItems: [ToDoItem] = []
  
  func add(item: ToDoItem) {
    if !toDoItems.contains(item) {
      toDoItems.append(item)
    }
  }
  
  func itemAt(index: Int) -> ToDoItem {
    return toDoItems[index]
  }
  
  func checkItemAt(index: Int) {
    let item = toDoItems.remove(at: index)
    doneItems.append(item)
  }
  
  func doneItemAt(index: Int) -> ToDoItem {
    return doneItems[index]
  }
  
  func removeAll() {
    toDoItems.removeAll()
    doneItems.removeAll()
  }
}
