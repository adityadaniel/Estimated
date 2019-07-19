//
//  EstimationHistoryCell.swift
//  Estimated
//
//  Created by Daniel Aditya Istyana on 18/07/19.
//  Copyright © 2019 Daniel Aditya Istyana. All rights reserved.
//

import UIKit

class EstimationHistoryCell: UITableViewCell {

  
  @IBOutlet weak var taskNameLabel: UILabel!
  @IBOutlet weak var dateLabel: UILabel!
  @IBOutlet weak var accuracyStatusLabel: UILabel!
  @IBOutlet weak var differenceLabel: UILabel!
  @IBOutlet weak var accuracyPercentLabel: UILabel! {
    didSet {
      accuracyPercentLabel.backgroundColor = Colors.lightRed
      accuracyPercentLabel.textColor = .white
      accuracyPercentLabel.layer.cornerRadius = 20
    }
  }
  
  
}
