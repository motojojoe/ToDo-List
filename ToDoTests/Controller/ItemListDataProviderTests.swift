//
//  ItemListDataProviderTests.swift
//  ToDoTests
//
//  Created by Atthachai  on 7/18/17.
//

import XCTest
@testable import ToDo

class ItemListDataProviderTests: XCTestCase {
  var sut: ItemListDataProvider!
  var tableView: UITableView!
  var controller: ItemListViewController!
  
  override func setUp() {
    super.setUp()
    sut = ItemListDataProvider()
    sut.itemManager = ItemManager()
    
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    controller = storyboard.instantiateViewController(withIdentifier: "ItemListViewController") as! ItemListViewController
    
    _ = controller.view
    
    tableView = controller.tableView
    tableView.dataSource = sut
  }
  
  override func tearDown() {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    super.tearDown()
  }
  
  func test_NumberOfSections_IsTwo() {
    let numberOfSections = tableView.numberOfSections
    XCTAssertEqual(numberOfSections, 2)
  }
  
  func test_NumberOfRows_InFirstSection_IsToDoCount() {
    sut.itemManager?.add(item: ToDoItem(title: "Foo"))
    XCTAssertEqual(tableView.numberOfRows(inSection: 0), 1)
    
    sut.itemManager?.add(item: ToDoItem(title: "Bar"))
    tableView.reloadData()
    XCTAssertEqual(tableView.numberOfRows(inSection: 0), 2)
  }
  
  func test_NumberOfRows_InSecondSection_IsDoneCount() {
    sut.itemManager?.add(item: ToDoItem(title: "Foo"))
    sut.itemManager?.add(item: ToDoItem(title: "Bar"))
    
    sut.itemManager?.checkItemAt(index: 0)
    
    XCTAssertEqual(tableView.numberOfRows(inSection: 1), 1)
    
    sut.itemManager?.checkItemAt(index: 0)
    tableView.reloadData()
    
    XCTAssertEqual(tableView.numberOfRows(inSection: 1), 2)
  }
  
  func test_CellForRow_ReturnItemCell() {
    sut.itemManager?.add(item: ToDoItem(title: "Foo"))
    tableView.reloadData()
    let cell = tableView.cellForRow(at: IndexPath(row: 0, section: 0))
    XCTAssertTrue(cell is ItemCell)
  }
  
  func test_CellForRow_DequeuesCellFromTableView() {
    let mockTableView = MockTableView()
    mockTableView.dataSource = sut
    mockTableView.register(ItemCell.self, forCellReuseIdentifier: "ItemCell")
    
    sut.itemManager?.add(item: ToDoItem(title: "Foo"))
    mockTableView.reloadData()
    
    _ = mockTableView.cellForRow(at: IndexPath(row: 0, section: 0))
    
    XCTAssertTrue(mockTableView.cellGotDequeued)
  }
  
  func test_CellForRow_CallsConfigCell() {
    let mockTableView = MockTableView()
    mockTableView.dataSource = sut
    mockTableView.register(MockItemCell.self, forCellReuseIdentifier: "ItemCell")
    let item = ToDoItem(title: "Foo")
    sut.itemManager?.add(item: item)
    mockTableView.reloadData()
    
    let cell = mockTableView.cellForRow(at: IndexPath(row: 0, section: 0)) as! MockItemCell
    
    XCTAssertEqual(cell.catchedItem, item)
  }
}

extension ItemListDataProviderTests {
  class MockTableView: UITableView {
    var cellGotDequeued = false
    override func dequeueReusableCell(withIdentifier identifier: String, for indexPath: IndexPath) -> UITableViewCell {
      cellGotDequeued = true
      return super.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
    }
  }
  
  class MockItemCell: ItemCell {
    var catchedItem: ToDoItem?
    
    override func configCell(with item: ToDoItem) {
      catchedItem = item
    }
  }
}
