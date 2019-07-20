//
//  EstimationPerformanceCell.swift
//  Estimated
//
//  Created by Daniel Aditya Istyana on 20/07/19.
//  Copyright © 2019 Daniel Aditya Istyana. All rights reserved.
//

import UIKit
import Charts

class EstimationPerformanceCell: UITableViewCell {

  var estimationData: [Activity] = []
    
  @IBOutlet weak var lineChartView: LineChartView!
  
  func getAccuracyData() {
    for estimation in estimationData {
      
    }
  }
  
}
