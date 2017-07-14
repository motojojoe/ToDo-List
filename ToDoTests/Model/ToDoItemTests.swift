//
//  ToDoItemTests.swift
//  ToDoTests
//
//  Created by Atthachai  on 7/11/17.
//

import XCTest
@testable import ToDo

class ToDoItemTests: XCTestCase {
    
  override func setUp() {
    super.setUp()
    // Put setup code here. This method is called before the invocation of each test method in the class.
  }
  
  override func tearDown() {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    super.tearDown()
  }
  
  func test_Init_WhenGivenTitle_SetsTitle() {
    let item = ToDoItem(title: "Foo")
    XCTAssertEqual(item.title, "Foo", "should set title")
  }
  
  func test_Init_WhenGivenDescription_SetsDescription() {
    let item = ToDoItem(title: "", itemDescription: "Bar")
    XCTAssertEqual(item.itemDescription, "Bar", "should set itemDescription")
  }
  
  func test_Init_WhenGivenTimestamp_SetsTimestamp() {
    let item = ToDoItem(title: "", timestamp: 0.0)
    XCTAssertEqual(item.timestamp, 0.0, "should set timestamp")
  }
  
  func test_Init_WhenGivenLocation_Setslocation() {
    let location = Location(name: "Foo")
    let item = ToDoItem(title: "", location: location)
    XCTAssertEqual(item.location?.name, location.name, "should set location")
  }
  
  func test_EqualItems_AreEqual() { 
    let first = ToDoItem(title: "Foo")
    let second = ToDoItem(title: "Foo")
    
    XCTAssertEqual(first, second)
  }
  
  func test_Items_WhenLocationDiffers_AreNotEqual() {
    let first = ToDoItem(title: "", location: Location(name: "Foo"))
    let second = ToDoItem(title: "", location: Location(name: "Bar"))
    
    XCTAssertNotEqual(first, second)
  }
  
  func test_Items_WhenOneLocationIsNilAndTheOtherIsNot_AreNotEqual() {
    var first = ToDoItem(title: "", location: Location(name: "Foo"))
    var second = ToDoItem(title: "", location: nil)
    
    XCTAssertNotEqual(first, second)
    
    first = ToDoItem(title: "", location: nil)
    second = ToDoItem(title: "", location: Location(name: "Foo"))
    
    XCTAssertNotEqual(first, second)
  }
  
  func test_Items_WhenTimestampDiffers_AreNotEqual() {
    let first = ToDoItem(title: "Foo", timestamp: 1.0)
    let second = ToDoItem(title: "Foo", timestamp: 0.0)
    
    XCTAssertNotEqual(first, second)
  }
  
  func test_Items_WhenDescriptionDiffers_AreNotEqual() {
    let first = ToDoItem(title: "Foo", itemDescription: "Bar")
    let second = ToDoItem(title: "Foo", itemDescription: "Baz")
    
    XCTAssertNotEqual(first, second)
  }
  
  func test_Items_WhenTitleDiffers_AreNotEqual() {
    let first = ToDoItem(title: "Foo")
    let second = ToDoItem(title: "Bar")
    
    XCTAssertNotEqual(first, second)
  }
}
