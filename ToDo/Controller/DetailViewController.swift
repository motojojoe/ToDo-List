//
//  DetailViewController.swift
//  ToDo
//
//  Created by Atthachai  on 7/20/17.
//

import UIKit
import MapKit

class DetailViewController: UIViewController {
  @IBOutlet var titleLabel: UILabel!
  @IBOutlet var dueDateLabel: UILabel!
  @IBOutlet var descriptionLabel: UILabel!
  @IBOutlet var locationNameLabel: UILabel!
  @IBOutlet var mapView: MKMapView!
  
  var itemInfo: (ItemManager, Int)?
  
  let dateFormatter: DateFormatter = {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "MM/dd/yyyy"
    return dateFormatter
  }()
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    guard let itemInfo = itemInfo else {
      return
    }
    let item = itemInfo.0.itemAt(index: itemInfo.1)
    titleLabel.text = item.title
    locationNameLabel.text = item.location?.name
    descriptionLabel.text = item.itemDescription
    
    if let timestamp = item.timestamp {
      let date = Date(timeIntervalSince1970: timestamp)
      dueDateLabel.text = dateFormatter.string(from: date)
    }
    
    if let coordinate = item.location?.coordinate {
      let region = MKCoordinateRegionMakeWithDistance(coordinate, 100, 100)
      mapView.region = region
    }
    
  }
  
  func checkItem() {
    if let itemInfo = itemInfo {
      itemInfo.0.checkItemAt(index: itemInfo.1)
    }
  }
}
