//
//  EstimationHistoryCell.swift
//  Estimated
//
//  Created by Daniel Aditya Istyana on 18/07/19.
//  Copyright © 2019 Daniel Aditya Istyana. All rights reserved.
//

import UIKit

class EstimationHistoryCell: UITableViewCell {
  
  var estimation: Activity? {
    didSet {
      if let estimationDataExist = estimation {
        taskNameLabel.text = estimationDataExist.taskName!
        taskDateLabel.text = setDate(d: estimationDataExist.date!)
        
        
        if estimationDataExist.isCancelled {
          percentAccuracyBackgroundView.backgroundColor = .lightGray
          accuracyStatusLabel.text = estimationDataExist.cancellationReason
          percentAccuracyLabel.text = "-"
        } else {
          if estimationDataExist.estimatedTime > estimationDataExist.spentTime {
            let percentAccuracy = estimationDataExist.spentTime / estimationDataExist.estimatedTime * 100
            percentAccuracyLabel.text = "\(percentAccuracy)%"
            percentAccuracyBackgroundView.backgroundColor = Colors.purple
            accuracyStatusLabel.textColor = Colors.purple
            let difference = estimationDataExist.estimatedTime - estimationDataExist.spentTime * -1
            accuracyStatusLabel.text = "You're early \(timeString(time: TimeInterval(difference)))"
          } else {
            let percentAccuracy = estimationDataExist.estimatedTime / estimationDataExist.spentTime * 100
            percentAccuracyLabel.text = "\(percentAccuracy)%"
            percentAccuracyBackgroundView.backgroundColor = Colors.lightRed
            accuracyStatusLabel.textColor = Colors.lightRed
            let difference = estimationDataExist.estimatedTime - estimationDataExist.spentTime
            accuracyStatusLabel.text = "You're late \(timeString(time: TimeInterval(difference)))"
          }
        }
      } else {
        taskNameLabel.text = ""
        percentAccuracyLabel.text = ""
        accuracyStatusLabel.text = ""
        taskDateLabel.text = ""
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
  
  func timeString(time:TimeInterval) -> String {
    let hours = Int(time) / 3600
    let minutes = Int(time) / 60 % 60
    let seconds = Int(time) % 60
    return String(format:"%02i : %02i : %02i", hours, minutes, seconds)
  }
  
  
}
