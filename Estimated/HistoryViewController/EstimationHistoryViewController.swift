//
//  EstimationHistoryViewController.swift
//  Estimated
//
//  Created by Daniel Aditya Istyana on 18/07/19.
//  Copyright © 2019 Daniel Aditya Istyana. All rights reserved.
//

import UIKit
import Charts
import CoreData

class EstimationHistoryViewController: UIViewController {
  
  var estimations = [Activity]()
  var notCancelledEstimations = [Activity]()
  var notCancelledPredicate: NSPredicate?
  
  private let appDelegate = UIApplication.shared.delegate as! AppDelegate
  private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
  
  @IBOutlet weak var tableView: UITableView!

  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupCell()
    navigationController?.navigationBar.prefersLargeTitles = true
    title = "Estimation History"
    
    navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Delete all record", style: .plain, target: self, action: #selector(deleteEstimations))
    
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    fetchEstimations()
    tableView.reloadData()
  }
  
  // MARK: - Setup custom cell
  func setupCell() {
    let chartCell = UINib(nibName: "ChartCell", bundle: nil)
    tableView.register(chartCell, forCellReuseIdentifier: "ChartCell")
    
    let historyCell = UINib(nibName: "EstimationHistoryCell", bundle: nil)
    tableView.register(historyCell, forCellReuseIdentifier: "EstimationHistoryCell")
  }
  
  // MARK: - CoreData Function
  // Core data sort by latest entries
  func sortEstimationBasedOnDate() -> [NSSortDescriptor?] {
    return [NSSortDescriptor(key: "date", ascending: false)]
  }
  
  func fetchEstimations() {
    do {
      let activityFetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Activity")
      let sortByDate = NSSortDescriptor(key: "date", ascending: false)
      
      // Sort by date
      activityFetchRequest.sortDescriptors = [sortByDate]
      
      // Fetch core data
      estimations = try context.fetch(activityFetchRequest) as! [Activity]
      
      // Add core data predicate to filter data that is cancelled
//      activityFetchRequest.predicate = notCancelledPredicate
//      notCancelledPredicate = NSPredicate(value: false)
      
      // Fetch estimation data that is not cancelled and store to array
//      notCancelledEstimations = try context.fetch(activityFetchRequest) as! [Activity]
      
    } catch let error as NSError {
      print("Could not fetch. \(error), \(error.userInfo)")
    }
  }
  
  func deleteAllActivity() {
    let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Activity")
    let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
    do {
      try context.execute(batchDeleteRequest)
    } catch let er as NSError {
      print("Something wrong", er)
    }
    
    tableView.reloadData()
  }
  
  @objc func deleteEstimations() {
    self.deleteAllActivity()
  }
  
}

extension EstimationHistoryViewController: UITableViewDataSource, UITableViewDelegate {
  
  enum HistorySection: Int {
    case ChartSection = 0, EstimationHistorySection
  }
  
  func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    switch section {
    case 1:
      if estimations.count >= 1 {
        return "Your estimations history"
      } else {
        return "No estimations history found"
      }
    default:
      break
    }
    return ""
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
      let cell = tableView.dequeueReusableCell(withIdentifier: "EstimationPerformanceCell", for: indexPath) as! EstimationPerformanceCell
      notCancelledEstimations = estimations.filter { (activity) -> Bool in
        activity.isCancelled == false
      }
      return cell
    } else if section == HistorySection.EstimationHistorySection.rawValue {
      let cell = tableView.dequeueReusableCell(withIdentifier: "EstimationHistoryCell", for: indexPath) as! EstimationHistoryCell
      if estimations.count >= 1 {
        cell.estimation = estimations[indexPath.row]
      } else {
        cell.estimation = nil
      }
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
