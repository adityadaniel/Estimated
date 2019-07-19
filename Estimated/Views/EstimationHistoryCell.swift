//
//  EstimationHistoryCell.swift
//  Estimated
//
//  Created by Daniel Aditya Istyana on 18/07/19.
//  Copyright © 2019 Daniel Aditya Istyana. All rights reserved.
//

import UIKit

class EstimationHistoryCell: UITableViewCell {
  
  var estimation: EstimationHistory! {
    didSet {
      taskNameLabel.text = estimation.taskName!
      dateLabel.text = estimation.date!
      accuracyStatusLabel.text = "\(estimation.accuracy!)%"
      let difference = (estimation.estimation! - estimation.timeSpent!) / estimation.estimation! * 100
      if difference < 0 {
        accuracyStatusLabel.text = "You're \(difference * -1) late"
        accuracyBackgroundView.backgroundColor = Colors.lightRed
        accuracyStatusLabel.textColor = Colors.lightRed
      } else {
        accuracyStatusLabel.text = "You're \(difference) early"
        accuracyBackgroundView.backgroundColor = Colors.purple
        accuracyStatusLabel.textColor = Colors.purple
      }
    }
  }

  
  @IBOutlet weak var taskNameLabel: UILabel!
  @IBOutlet weak var dateLabel: UILabel!
  @IBOutlet weak var accuracyStatusLabel: UILabel!
  @IBOutlet weak var accuracyBackgroundView: UIView! {
    didSet {
      self.accuracyBackgroundView.layer.cornerRadius = 8
    }
  }
  @IBOutlet weak var accuracyPercentLabel: UILabel!
  
  
}
