//
//  LocationTests.swift
//  ToDoTests
//
//  Created by Atthachai  on 7/12/17.
//

import XCTest
@testable import ToDo
import CoreLocation

class LocationTests: XCTestCase {
    
  override func setUp() {
    super.setUp()
    // Put setup code here. This method is called before the invocation of each test method in the class.
  }
  
  override func tearDown() {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    super.tearDown()
  }
  
  func test_Init_WhenGivenCoordinate_SetsCoordinate() {
    let coordinate = CLLocationCoordinate2D(latitude: 1, longitude: 2)
    let location  = Location(name: "", coordinate: coordinate)
    
    XCTAssertEqual(location.coordinate?.latitude, coordinate.latitude)
    XCTAssertEqual(location.coordinate?.longitude, coordinate.longitude)
  }
  
  func test_Init_WhenGivenName_SetsName() {
    let item = Location(name: "Foo")
    XCTAssertEqual(item.name, "Foo", "should set name")
  }
  
  func test_EqualLocations_AreEqual() {
    let first = Location(name: "Foo")
    let second = Location(name: "Foo")
    
    XCTAssertEqual(first, second)
  }
  
  func test_EqualLocations_WhenLatitudeDiffers_AreNotEqual() {
    performNotEqualTestWith(firstName: "Foo", secondName: "Foo", firstLongLat: (0.0, 1.0), secondLongLat: (0.0, 0.0), line: #line)
  }
  
  func test_EqualLocations_WhenLongtitudeDiffers_AreNotEqual() {
    performNotEqualTestWith(firstName: "Foo", secondName: "Foo", firstLongLat: (1.0, 0.0), secondLongLat: (0.0, 0.0), line: #line)
  }
  
  func test_Locations_WhenOnlyoneHasCoordinate_AreNotEqual() {
    performNotEqualTestWith(firstName: "Foo", secondName: "Foo", firstLongLat: (1.0, 0.0), secondLongLat: nil, line: #line)
  }
  
  func test_Locations_WhenNamesDiffer_AreNotEqual() {
    performNotEqualTestWith(firstName: "Foo", secondName: "Bar", firstLongLat: nil, secondLongLat: nil, line: #line)
  }
  
  func performNotEqualTestWith(firstName: String, secondName: String, firstLongLat:(Double, Double)?, secondLongLat:(Double, Double)?, line: UInt) {
    var firstCoordinate: CLLocationCoordinate2D? = nil
    if let firstLongLat = firstLongLat {
      firstCoordinate = CLLocationCoordinate2D(latitude: firstLongLat.0, longitude: firstLongLat.1)
    }
    let firstLocation = Location(name: firstName, coordinate: firstCoordinate)
    
    var secondCoordinate: CLLocationCoordinate2D? = nil
    if let secondLongLat = secondLongLat {
      secondCoordinate = CLLocationCoordinate2D(latitude: secondLongLat.0, longitude: secondLongLat.1)
    }
    let secondLocation = Location(name: secondName, coordinate: secondCoordinate)
    
    XCTAssertNotEqual(firstLocation, secondLocation, line: line)
  }
}

