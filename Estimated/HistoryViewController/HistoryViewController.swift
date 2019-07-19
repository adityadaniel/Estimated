//
//  HistoryViewController.swift
//  Estimated
//
//  Created by Daniel Aditya Istyana on 18/07/19.
//  Copyright © 2019 Daniel Aditya Istyana. All rights reserved.
//

import UIKit

class HistoryViewController: UIViewController {
  
  
  
  var estimations: [EstimationHistory] = [EstimationHistory]()
  
  let est1 = EstimationHistory(taskName: "Write report 1", date: "27/08/2019", timeSpent: 1800, estimation: 900, accuracy: 50, accuracyStatus: true)
  let est2 = EstimationHistory(taskName: "Write report 2", date: "28/08/2019", timeSpent: 900, estimation: 1800, accuracy: 50, accuracyStatus: false)
  let est3 = EstimationHistory(taskName: "Write report 3", date: "29/08/2019", timeSpent: 1800, estimation: 900, accuracy: 50, accuracyStatus: true)
  let est4 = EstimationHistory(taskName: "Write report 4", date: "21/08/2019", timeSpent: 900, estimation: 1800, accuracy: 50, accuracyStatus: false)
  let est5 = EstimationHistory(taskName: "Write report 5", date: "24/08/2019", timeSpent: 1800, estimation: 900, accuracy: 50, accuracyStatus: true)
  let est6 = EstimationHistory(taskName: "Write report 6", date: "23/08/2019", timeSpent: 1800, estimation: 900, accuracy: 50, accuracyStatus: true)

  
  @IBOutlet weak var tableView: UITableView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    estimations = [est1, est2, est3, est4, est5, est6]
    
    navigationController?.navigationBar.prefersLargeTitles = true
    title = "Estimation History"
    
    setupCell()
    
  }
  
  func setupCell() {
    let chartCell = UINib(nibName: "ChartCell", bundle: nil)
    tableView.register(chartCell, forCellReuseIdentifier: "ChartCell")
    
    let historyCell = UINib(nibName: "EstimationHistoryCell", bundle: nil)
    tableView.register(historyCell, forCellReuseIdentifier: "EstimationHistoryCell")
  }
}

extension HistoryViewController: UITableViewDataSource, UITableViewDelegate {
  
  enum HistorySection: Int {
    case ChartSection = 0, EstimationHistorySection
  }
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return 2
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    switch section {
    case HistorySection.ChartSection.rawValue:
      return 1
    case HistorySection.EstimationHistorySection.rawValue:
      return estimations.count
    default:
      break
    }
    return 0
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let section = indexPath.section
    
    if section == HistorySection.ChartSection.rawValue {
      let cell = tableView.dequeueReusableCell(withIdentifier: "ChartCell", for: indexPath) as! ChartCell
      return cell
    } else if section == HistorySection.EstimationHistorySection.rawValue {
      let cell = tableView.dequeueReusableCell(withIdentifier: "EstimationHistoryCell", for: indexPath) as! EstimationHistoryCell
      cell.estimation = estimations[indexPath.row]
      return cell
    } else {
      return UITableViewCell()
    }
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    let section = indexPath.section
    
    switch section {
    case HistorySection.ChartSection.rawValue:
      return 250
    case HistorySection.EstimationHistorySection.rawValue:
      return 100
    default:
      break
    }
    return 0
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: false)
  }
  
}
