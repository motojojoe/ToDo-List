//
//  ItemManagerTests.swift
//  ToDoTests
//
//  Created by Atthachai  on 7/12/17.
//

import XCTest
@testable import ToDo

class ItemManagerTests: XCTestCase {
  
  var sut: ItemManager!
  
  override func setUp() {
    super.setUp()
    sut = ItemManager()
  }
  
  override func tearDown() {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    super.tearDown()
  }
  
  func test_ToDoCount_Initially_IsZero() {
    XCTAssertEqual(sut.toDoCount, 0)
  }
  
  func test_DoneCount_Initially_IsZero() {
    XCTAssertEqual(sut.doneCount, 0)
  }
  
  func test_AddItem_IncreasesToDoCountToOne() {
    sut.add(item: ToDoItem(title: ""))
    XCTAssertEqual(sut.toDoCount, 1)
  }
  
  func test_ItemAt_AfterAddingAnItem_ReturnsThatItem() {
    let item = ToDoItem(title: "Foo")
    sut.add(item: item)
    
    let returnedItem = sut.itemAt(index: 0)
    XCTAssertEqual(returnedItem.title, item.title)
  }
  
  func test_CheckItemAt_ChangesCounts(){
    sut.add(item: ToDoItem(title: ""))
    sut.checkItemAt(index: 0)
    
    XCTAssertEqual(sut.toDoCount, 0)
    XCTAssertEqual(sut.doneCount, 1)
    
  }
  
  func test_CheckItemAt_RemoveItFromToDoItems() {
    let first = ToDoItem(title: "First")
    let second = ToDoItem(title: "Second")
    
    sut.add(item: first)
    sut.add(item: second)
    
    sut.checkItemAt(index: 0)
    
    XCTAssertEqual(sut.itemAt(index: 0).title, "Second")
  }
  
  func test_DoneItemAt_ReturnCheckedItem() {
    let item = ToDoItem(title: "Foo")
    
    sut.add(item: item)
    sut.checkItemAt(index: 0)
    
    let returnedItem = sut.doneItemAt(index: 0)
    
    XCTAssertEqual(returnedItem.title, item.title)
  }
  
  func test_RemoveAll_ResultInCountsBeZero() {
    sut.add(item: ToDoItem(title: "Foo"))
    sut.add(item: ToDoItem(title: "Bar"))
    
    sut.checkItemAt(index: 0)
    
    XCTAssertEqual(sut.toDoCount, 1)
    XCTAssertEqual(sut.doneCount, 1)
    
    sut.removeAll()
    
    XCTAssertEqual(sut.toDoCount, 0)
    XCTAssertEqual(sut.doneCount, 0)
  }
  
  func test_WhenItemIsAlreadyAdded_DoesNotIncreaseCont() {
    sut.add(item: ToDoItem(title: "Foo"))
    sut.add(item: ToDoItem(title: "Foo"))
    
    XCTAssertEqual(sut.toDoCount, 1)
  }
    
}
