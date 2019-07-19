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
  
  struct Estimation {
    var taskName: String?
    var taskDate: String?
    var timeSpent: Int?
    var estimation: Int?
    var estimationAccuracyStatus: String?
  }
  
  
  let task1 = Estimation(taskName: "Write proposal", taskDate: "28 / 09 / 1220", timeSpent: 3600, estimation: 7200, estimationAccuracyStatus: "You're early")
  let task2 = Estimation(taskName: "Write proposal 3", taskDate: "28 / 09 / 1220", timeSpent: 3600, estimation: 7200, estimationAccuracyStatus: "You're early")
  let task3 = Estimation(taskName: "Write proposal 4", taskDate: "28 / 09 / 1220", timeSpent: 3600, estimation: 7200, estimationAccuracyStatus: "You're early")

  var tasks: [Estimation] = [Estimation]()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    navigationController?.navigationBar.prefersLargeTitles = true
    title = "Estimation History"
    
    setupCell()
    
    tasks = [task1, task2, task3]
    
    print(tasks[1].taskName!)
  }
  
  func setupCell() {
    let estimationHistoryCell = UINib(nibName: "EstimationHistoryCell", bundle: nil)
    tableView.register(estimationHistoryCell, forCellReuseIdentifier: "EstimationHistoryCell")
  }
  
}


extension HistoryViewController: UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 100
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return tasks.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "EstimationHistoryCell", for: indexPath) as! EstimationHistoryCell
    let task = tasks[indexPath.row]
    cell.taskNameLabel.text = task.taskName!
    cell.dateLabel.text = task.taskDate!
    return cell
  }
  
  
}

extension HistoryViewController: UITableViewDelegate {
  
}
