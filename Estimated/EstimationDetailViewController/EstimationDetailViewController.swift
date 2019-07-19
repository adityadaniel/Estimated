//
//  EstimationDetailViewController.swift
//  Estimated
//
//  Created by Daniel Aditya Istyana on 19/07/19.
//  Copyright © 2019 Daniel Aditya Istyana. All rights reserved.
//

import UIKit

class EstimationDetailViewController: UIViewController {

  @IBOutlet weak var estimationChart: UIView!
  @IBOutlet weak var tableView: UITableView!
  
  override func viewDidLoad() {
        super.viewDidLoad()

      
    }

}

extension EstimationDetailViewController: UITableViewDataSource, UITableViewDelegate {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if section == 0 {
      return 5
    }
    return 1
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "EstimationDetailCell", for: indexPath) 
    switch indexPath.row {
    case 1:
      cell.textLabel?.text = ""
      cell.detailTextLabel?.text = ""
    default:
      break
    }
    return cell
  }
  
  
}
