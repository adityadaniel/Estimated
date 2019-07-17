//
//  TaskNameCell.swift
//  Estimated
//
//  Created by Daniel Aditya Istyana on 15/07/19.
//  Copyright © 2019 Daniel Aditya Istyana. All rights reserved.
//

import UIKit

protocol TaskNameDelegate: class {
    func finishAddingTaskName(taskName: String)
}


class TaskNameCell: UITableViewCell, UITextFieldDelegate {

    weak var taskNameCellDelegate: TaskNameDelegate?
    
    @IBOutlet weak var taskNameTextField: UITextField!
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        print(textField.text!)
        return true
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.taskNameCellDelegate?.finishAddingTaskName(taskName: textField.text!)
        textField.resignFirstResponder()
        return true
    }

}
