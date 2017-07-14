//
//  ItemListViewControllerTest.swift
//  ToDoTests
//
//  Created by Atthachai  on 7/14/17.
//

import XCTest
@testable import ToDo

class ItemListViewControllerTest: XCTestCase {
  
  override func setUp() {
    super.setUp()
    // Put setup code here. This method is called before the invocation of each test method in the class.
  }
  
  override func tearDown() {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    super.tearDown()
  }
  
  func test_TableViewIsNotNilAfterViewDidLoad() {
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    let viewController = storyboard.instantiateViewController(withIdentifier: "ItemListViewController")
    let sut = viewController as! ItemListViewController
    _ = sut.view // is to trigger the call of viewDidLoad(). Never call viewDidLoad() directly.
    XCTAssertNotNil(sut.tableView)
  }
  
  
  
}
