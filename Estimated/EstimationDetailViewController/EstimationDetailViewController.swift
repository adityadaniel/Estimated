//
//  EstimationDetailViewController.swift
//  Estimated
//
//  Created by Daniel Aditya Istyana on 19/07/19.
//  Copyright © 2019 Daniel Aditya Istyana. All rights reserved.
//

import UIKit
import Charts

class EstimationDetailViewController: UIViewController {
  
  var barChartData: BarChartData!
  
  
  @IBOutlet weak var tableView: UITableView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupCell()
  }
  
  func setupCell() {
    let detailChartCell = UINib(nibName: "EstimationDetailChartCell", bundle: nil)
    tableView.register(detailChartCell, forCellReuseIdentifier: "EstimationDetailChartCell")
  }
  
}

extension EstimationDetailViewController: UITableViewDataSource, UITableViewDelegate {
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    switch indexPath.section {
    case 0:
      return 250
    default:
      break
    }
    return 100
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    switch section {
    case 0:
      return 1
    case 1:
      return 5
    default:
      break
    }
    return 1
  }
  
  
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    switch indexPath.section {
    case 0:
      let cell = tableView.dequeueReusableCell(withIdentifier: "EstimationDetailChartCell", for: indexPath) as! EstimationDetailChartCell
      cell.barChartView.data = barChartData
      return cell
    default:
      break
    }
    return UITableViewCell()
  }
}
