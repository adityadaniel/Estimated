//
//  EstimationHistoryCell.swift
//  Estimated
//
//  Created by Daniel Aditya Istyana on 18/07/19.
//  Copyright © 2019 Daniel Aditya Istyana. All rights reserved.
//

import UIKit

class EstimationHistoryCell: UITableViewCell {
  
  var estimation: Activity! {
    didSet {
      taskNameLabel.text = estimation.taskName!
      taskDateLabel.text = setDate(d: estimation.date!)
    
      
      if estimation.isCancelled {
        percentAccuracyBackgroundView.backgroundColor = .lightGray
        accuracyStatusLabel.text = estimation.cancellationReason
        percentAccuracyLabel.text = "-"
      } else {
        if estimation.estimatedTime > estimation.spentTime {
          let percentAccuracy = estimation.spentTime / estimation.estimatedTime * 100
          percentAccuracyLabel.text = "\(percentAccuracy)%"
          percentAccuracyBackgroundView.backgroundColor = Colors.purple
          accuracyStatusLabel.textColor = Colors.purple
          accuracyStatusLabel.text = "You're early \(estimation.estimatedTime - estimation.spentTime) mins"
        } else {
          let percentAccuracy = estimation.estimatedTime / estimation.spentTime * 100
          percentAccuracyLabel.text = "\(percentAccuracy)%"
          percentAccuracyBackgroundView.backgroundColor = Colors.lightRed
          percentAccuracyLabel.textColor = Colors.lightRed
          accuracyStatusLabel.text = "You're late \(estimation.spentTime - estimation.estimatedTime) mins"
        }
      }
    }
  }
  
  func setDate(d:Date) -> String {
    let dateFormat = DateFormatter()
    dateFormat.dateFormat = "yyyy/MM/dd HH:mm"
    let date = dateFormat.string(from: d)
    return date
  }
  

  @IBOutlet weak var taskNameLabel: UILabel!
  @IBOutlet weak var accuracyStatusLabel: UILabel!
  @IBOutlet weak var taskDateLabel: UILabel!
  @IBOutlet weak var percentAccuracyLabel: UILabel!
  @IBOutlet weak var percentAccuracyBackgroundView: UIView! {
    didSet {
      percentAccuracyBackgroundView.layer.cornerRadius = 8
    }
  }
  
  
  
}
