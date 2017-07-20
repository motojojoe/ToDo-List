//
//  DetailViewControllerTests.swift
//  ToDoTests
//
//  Created by Atthachai  on 7/20/17.
//

import XCTest
@testable import ToDo
import CoreLocation

class DetailViewControllerTests: XCTestCase {
  var sut: DetailViewController!
  
  override func setUp() {
    super.setUp()
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    sut = storyboard.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
    _ = sut.view
  }
  
  override func tearDown() {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    super.tearDown()
  }
  
  func test_HasTitleLabel() {
    XCTAssertNotNil(sut.titleLabel)
  }
  
  func test_HasDueDate() {
    XCTAssertNotNil(sut.dueDateLabel)
  }
  
  func test_HasDescriptionLabel() {
    XCTAssertNotNil(sut.descriptionLabel)
  }
  
  func test_HasLocationNameLabel() {
    XCTAssertNotNil(sut.locationNameLabel)
  }
  
  func test_HasMapView() {
    XCTAssertNotNil(sut.mapView)
  }
  
  func test_SettingItemInfo_SetsTextsToLabels() {
    let coordinate = CLLocationCoordinate2D(latitude: 51.2277, longitude: 6.7735)
    let location = Location(name: "Foo", coordinate: coordinate)
    let item = ToDoItem(title: "Bar", itemDescription: "Baz", timestamp: 1456150025, location: location)
    
    let itemManager = ItemManager()
    itemManager.add(item: item)
    
    sut.itemInfo = (itemManager, 0)
    
    sut.beginAppearanceTransition(true, animated: true)
    sut.endAppearanceTransition()
    
    XCTAssertEqual(sut.titleLabel.text, "Bar")
    XCTAssertEqual(sut.dueDateLabel.text, "02/22/2016")
    XCTAssertEqual(sut.locationNameLabel.text, "Foo")
    XCTAssertEqual(sut.descriptionLabel.text, "Baz")
    XCTAssertEqualWithAccuracy(sut.mapView.centerCoordinate.latitude, coordinate.latitude, accuracy: 0.001)
    XCTAssertEqualWithAccuracy(sut.mapView.centerCoordinate.longitude, coordinate.longitude, accuracy: 0.001)
    
  }
  
  func test_CheckItem_ChecksItemInItemManager() {
    let itemManager = ItemManager()
    itemManager.add(item: ToDoItem(title: "Foo"))
    
    sut.itemInfo = (itemManager, 0)
    
    sut.checkItem()
    
    XCTAssertEqual(itemManager.toDoCount, 0)
    XCTAssertEqual(itemManager.doneCount, 1)
  }
}
