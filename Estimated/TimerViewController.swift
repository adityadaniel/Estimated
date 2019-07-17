//
//  TimerViewController.swift
//  Estimated
//
//  Created by Daniel Aditya Istyana on 17/07/19.
//  Copyright © 2019 Daniel Aditya Istyana. All rights reserved.
//

import UIKit

class TimerViewController: UIViewController {

    @IBOutlet weak var circularProgressView: UIView!
    
    @IBOutlet weak var cancelButton: ETButton! {
        didSet {
            cancelButton.backgroundColor = Colors.darkRed
        }
    }
    @IBOutlet weak var doneButton: ETButton!
    
    
    @IBAction func cancelButtonDidTap(_ sender: ETButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func doneButtonDidTap(_ sender: ETButton) {
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.tintColor = Colors.purple
    }

}
