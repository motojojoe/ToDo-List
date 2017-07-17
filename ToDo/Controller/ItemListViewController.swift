//
//  ItemListViewController.swift
//  ToDo
//
//  Created by Atthachai  on 7/14/17.
//

import UIKit

class ItemListViewController: UIViewController {
  
  @IBOutlet weak var tableView: UITableView!
  @IBOutlet var dataProvider: (UITableViewDataSource & UITableViewDelegate)!
  
  override func viewDidLoad() {
    tableView.dataSource = dataProvider
    tableView.delegate = dataProvider
  }

  
}
