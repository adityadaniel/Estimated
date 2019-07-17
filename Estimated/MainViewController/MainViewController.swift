//
//  ViewController.swift
//  Estimated
//
//  Created by Daniel Aditya Istyana on 15/07/19.
//  Copyright © 2019 Daniel Aditya Istyana. All rights reserved.
//

import UIKit


class MainViewController: UIViewController {
    
    struct Estimation {
        var duration: TimeInterval?
        var reminderNotification: Int?
        var taskName: String?
    }
    
    var duration: Int = 60
    var intervalSetting = 5
    var taskName = ""
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Set Timer"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.tintColor = Colors.purple
        tabBarController?.tabBar.tintColor = Colors.purple
        
        
        setupCell()
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // check userdefaults
        UserDefaults.standard.set(false, forKey: "onboardingScreenShown")
        
        let isOnboardShown = UserDefaults.standard.bool(forKey: "onboardingScreenShown")
        
        if !isOnboardShown {
            //self.showOnboardingScreen()
            UserDefaults.standard.set(true, forKey: "onboardingScreenShown")
        }
    }
    
    
    @objc func keyboardWillShow(_ notification:Notification) {
        
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height, right: 0)
        }
    }
    
    @objc func keyboardWillHide(_ notification:Notification) {
        
        if ((notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue) != nil {
            tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        }
    }
    
    //MARK:- Prepare Segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        switch segue.identifier ?? "" {
        case "SetNotificatonReminderSegue":
            if let destinationController = segue.destination as? NotificationReminderSettingsViewController {
                destinationController.notificationIntervalDelegate = self
                destinationController.interval = intervalSetting
            }
        case "StartTimerSegue":
            let est = Estimation(duration: TimeInterval(self.duration), reminderNotification: self.intervalSetting, taskName: self.taskName)
            print(est)
        default:
            break
            
        }
    }
    
    
}
