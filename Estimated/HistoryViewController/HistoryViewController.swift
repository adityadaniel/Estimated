//
//  HistoryViewController.swift
//  Estimated
//
//  Created by Daniel Aditya Istyana on 18/07/19.
//  Copyright © 2019 Daniel Aditya Istyana. All rights reserved.
//

import UIKit
import CoreData

class HistoryViewController: UIViewController {
  
  public var estimations = [Activity]()
  
  private let appDelegate = UIApplication.shared.delegate as! AppDelegate
  private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
  
  @IBOutlet weak var tableView: UITableView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupCell()
    navigationController?.navigationBar.prefersLargeTitles = true
    title = "Estimation History"
    
    fetchEstimations()
    tableView.reloadData()
    
  }
  
  func sortEstimationBasedOnDate() -> [NSSortDescriptor?] {
    return [NSSortDescriptor(key: "date", ascending: false)]
  }
  
  func fetchEstimations() {
    do {
      let activityFetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Activity")
      let sortByDate = NSSortDescriptor(key: "date", ascending: false)
      activityFetchRequest.sortDescriptors = [sortByDate]
      estimations = try context.fetch(activityFetchRequest) as! [Activity]
      print(estimations)
    } catch let error as NSError {
      print("Could not fetch. \(error), \(error.userInfo)")
    }
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
