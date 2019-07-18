//
//  TimerViewController.swift
//  Estimated
//
//  Created by Daniel Aditya Istyana on 17/07/19.
//  Copyright © 2019 Daniel Aditya Istyana. All rights reserved.
//

import UIKit

class TimerViewController: UIViewController {
  
  var runningEstimationTimer: Estimation!
  
  weak var timer: Timer?
  
  var isTimerRunning = false
  
  lazy var timerStartedDate = Date()
  
  var seconds: Int = 0
  
  @IBOutlet weak var circularProgressBar: CircularProgressBar!
  
  @IBOutlet weak var cancelButton: ETButton! {
    didSet {
      cancelButton.backgroundColor = Colors.darkRed
    }
  }
  @IBOutlet weak var doneButton: ETButton!
  
  
  @IBAction func cancelButtonDidTap(_ sender: ETButton) {
    
    let alert = UIAlertController(title: "Cancel timer", message: "What's the reason?", preferredStyle: .alert)
    let okAction = UIAlertAction(title: "OK", style: .default) { (action) in
      self.timer?.invalidate()
      self.isTimerRunning = false
      self.dismiss(animated: true, completion: {
        self.dismiss(animated: true, completion: nil)
      })
    }
    let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
      self.timer?.invalidate()
      self.isTimerRunning = false
      self.dismiss(animated: true, completion: nil)
    }
    alert.addAction(okAction)
    alert.addAction(cancelAction)
    self.present(alert, animated: true, completion: nil)
  }
  
  @IBAction func doneButtonDidTap(_ sender: ETButton) {
    
    // invalidate timer
    // save timer to coredata
    // segue to history tab
    
    timer?.invalidate()
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    navigationController?.navigationBar.tintColor = Colors.purple
    startTimer()
  }

  
  func startTimer() {
    if !isTimerRunning {
      runTimer()
      isTimerRunning = true
    } else {
    }
  }
  
  func runTimer() {
    timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimerLabel), userInfo: nil, repeats: true)
    circularProgressBar.labelSize = 24
    circularProgressBar.safePercent = 80
    circularProgressBar.lineWidth = 20
  }
  
  func timeString(time:TimeInterval) -> String {
    let hours = Int(time) / 3600
    let minutes = Int(time) / 60 % 60
    let seconds = Int(time) % 60
    return String(format:"%02i : %02i : %02i", hours, minutes, seconds)
  }
  
  @objc func updateTimerLabel() {
    
    seconds += 1
    
//    let hours = Int(seconds) / 3600
//    let minutes = Int(seconds) / 60 % 60
//
//    let stringOfHours = String(format: "%02d", hours)
//    let stringOfMinutes = String(format: "%02d", minutes)
//    let stringOfSeconds = String(format: "%02d", seconds)
//
//    let timerText = "\(stringOfHours) : \(stringOfMinutes) : \(stringOfSeconds)"
    
//    timerLabel.text = timeString(time: TimeInterval(seconds))
    
    circularProgressBar.setLabel = timeString(time: TimeInterval(seconds))
    
    let progress = Double(seconds) / Double(runningEstimationTimer.duration!)
    if progress <= 1 {
      circularProgressBar.setProgress(to: progress, withAnimation: false)
    }
    
  }
}
