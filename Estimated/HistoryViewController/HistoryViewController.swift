//
//  HistoryViewController.swift
//  Estimated
//
//  Created by Daniel Aditya Istyana on 18/07/19.
//  Copyright © 2019 Daniel Aditya Istyana. All rights reserved.
//

import UIKit

class HistoryViewController: UIViewController {
  
  @IBOutlet weak var tableView: UITableView!
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    navigationController?.navigationBar.prefersLargeTitles = true
    title = "Estimation History"
    
    setupCell()
    
  }
  
  func setupCell() {
    let estimationHistoryCell = UINib(nibName: "EstimationHistoryCell", bundle: nil)
    tableView.register(estimationHistoryCell, forCellReuseIdentifier: "EstimationHistoryCell")
  }
  
}
