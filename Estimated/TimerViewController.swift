//
//  TimerViewController.swift
//  Estimated
//
//  Created by Daniel Aditya Istyana on 17/07/19.
//  Copyright © 2019 Daniel Aditya Istyana. All rights reserved.
//

import UIKit
import UserNotifications

class TimerViewController: UIViewController, UNUserNotificationCenterDelegate {
  
  var runningEstimationTimer: Estimation!
  
  weak var timer: Timer?
  
  var isTimerRunning = false
  
  lazy var timerStartedDate = Date()
  
  var seconds: Int = 0
  
  var diffHrs = 0
  var diffMins = 0
  var diffSecs = 0
  
  //adding container
  private let appDelegate = UIApplication.shared.delegate as! AppDelegate
  
  private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
  
  public var activities = [Activity]()
  
  @IBOutlet weak var circularProgressBar: CircularProgressBar!
  
  @IBOutlet weak var cancelButton: UIButton! {
    didSet {
      cancelButton.backgroundColor = .clear
      cancelButton.setTitleColor(.red, for: .normal)
    }
  }
  @IBOutlet weak var doneButton: ETButton!
  
  @IBOutlet weak var estimationLabel: UILabel!
  
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
    
    // show alert controller
    let alertController = UIAlertController(title: "Are you sure to finish this timer?", message: "Are you sure to finish the timer?", preferredStyle: .alert)
    
    let okAction = UIAlertAction(title: "Finish", style: .default) { (_) in
      self.timer?.invalidate()
      self.dismiss(animated: true, completion: nil)
      // save the data to core data
    }
    
    let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (_) in
      self.dismiss(animated: true, completion: nil)
    }
    
    alertController.addAction(okAction)
    alertController.addAction(cancelAction)

    // save timer to coredata
    // segue to history tab

  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    navigationController?.navigationBar.tintColor = Colors.purple
    title = "\(runningEstimationTimer.taskName!)"
    navigationController?.navigationBar.prefersLargeTitles = true
    
    let backButton = UIBarButtonItem(title: "", style: .plain, target: navigationController, action: nil)
    navigationItem.leftBarButtonItem = backButton
    
    startTimer()
    
    let durationInString = timeString(time: runningEstimationTimer.estimatedTime!)
    
    estimationLabel.text = "Estimation: \(durationInString)"
   //taskLabel.text = runningEstimationTimer.taskName!
    NotificationCenter.default.addObserver(self, selector: #selector(pauseWhenBackground(noti:)), name: UIApplication.didEnterBackgroundNotification, object: nil)
    NotificationCenter.default.addObserver(self, selector: #selector(willEnterForeground(noti:)), name: UIApplication.willEnterForegroundNotification, object: nil)
  }
  
  @objc func pauseWhenBackground(noti: Notification) {
    self.timer?.invalidate()
    let shared = UserDefaults.standard
    shared.set(Date(), forKey: "savedTime")
  }
  
  @objc func willEnterForeground(noti: Notification) {
    if let savedDate = UserDefaults.standard.object(forKey: "savedTime") as? Date {
      (diffHrs, diffMins, diffSecs) = TimerViewController.getTimeDifference(startDate: savedDate)
      
      self.refresh(hours: diffHrs, mins: diffMins, secs: diffSecs)
    }
  }
  
  static func getTimeDifference(startDate: Date) -> (Int, Int, Int) {
    let calendar = Calendar.current
    let components = calendar.dateComponents([.hour, .minute, .second], from: startDate, to: Date())
    return(components.hour!, components.minute!, components.second!)
  }
  
  func refresh (hours: Int, mins: Int, secs: Int) {
    let hrs = hours * 3600
    let minutes = mins * 60
    let s = secs
    seconds += hrs + minutes + s + 1
    self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimerLabel), userInfo: nil, repeats: true)
    
  }

  
  func startTimer() {
    if !isTimerRunning {
      runTimer()
      scheduleReminder()
      isTimerRunning = true
    } else {
    }
  }
  
  func runTimer() {
    timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimerLabel), userInfo: nil, repeats: true)
    circularProgressBar.labelSize = 24
    circularProgressBar.safePercent = 80
    circularProgressBar.lineWidth = 25
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
    
    let progress = Double(seconds) / Double(runningEstimationTimer.estimatedTime!)
    if progress <= 1 {
      circularProgressBar.setProgress(to: progress, withAnimation: false)
    }
    
  }

  
  //adding activity without cancel
  func addActivity(name: String, estimated: Int, spend: Int, date: Date) {
    let activity = Activity(entity: Activity.entity(), insertInto: context)
    activity.name = name
    activity.estimatedTime = Int32(estimated)
    activity.spendTime = Int32(spend)
    activity.date = date
    activity.isCancelled = false
    activities.append(activity)
    appDelegate.saveContext()
  }
  
  //adding activity with cancellation reason
  func addActivity(name: String, estimated: Int, spend: Int, date: Date, cancelReason: String) {
    let activity = Activity(entity: Activity.entity(), insertInto: context)
    activity.name = name
    activity.estimatedTime = Int32(estimated)
    activity.spendTime = Int32(spend)
    activity.date = date
    activity.isCancelled = true
    activity.cancellationReason = cancelReason
    activities.append(activity)
    appDelegate.saveContext()
  }
  
  //fetching activity and put it into activities array
  private func fetchActivity() {
    do {
      activities = try context.fetch(Activity.fetchRequest())
    } catch let error as NSError {
      print("Could not fetch. \(error), \(error.userInfo)")
    }
  }


    func scheduleReminder(){
        
        let estimation : TimeInterval = runningEstimationTimer.estimatedTime!
        let reminder = LocalNotificationManager()
        
        let date = Date()
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: date)
        let minute = calendar.component(.minute, from: date)
        
        reminder.notifications = [
            LocalNotificationManager.myNotif(id: "reminder", title: "You're past your estimation!", subtitle: "It is past \(hour):\(minute)", estimation: estimation)
        ]
        
        reminder.schedule()
        reminder.listScheduledNotifications()
    }

    
}
