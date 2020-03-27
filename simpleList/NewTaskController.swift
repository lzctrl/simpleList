//
//  NewTaskController.swift
//  simpleList
//
//  Created by Mikhail Lozovyy on 3/27/20.
//  Copyright © 2020 Mikhail Lozovyy. All rights reserved.
//

import UIKit

class NewTaskController: UITableViewController {
    
    @IBOutlet weak var taskNameField: UITextField!
    @IBOutlet weak var dueDatePicker: UIDatePicker!
    
    var createdTask : ((Bool) -> Void)?
    var didCreateTask : Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.rightBarButtonItem?.isEnabled = false
        self.navigationItem.rightBarButtonItem?.tintColor = UIColor.black.withAlphaComponent(0.5)
        
        taskNameField.delegate = self
        
        taskNameField.addTarget(self, action: #selector(textfieldEdited), for: .editingChanged)
        
        taskNameField.becomeFirstResponder()
    }
    
    @objc func textfieldEdited() {
        guard let name = taskNameField.text, !name.isEmpty else {
            self.navigationItem.rightBarButtonItem?.isEnabled = false
            self.navigationItem.rightBarButtonItem?.tintColor = UIColor.black.withAlphaComponent(0.5)
            return
        }
        
        self.navigationItem.rightBarButtonItem?.isEnabled = true
        self.navigationItem.rightBarButtonItem?.tintColor = UIColor.black
    }
    
    @IBAction func cancelButton_Tapped(_ sender: Any) {
        didCreateTask = false
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func doneButton_Tapped(_ sender: Any) {
        var newTask = TaskObject()
        
        newTask.name = taskNameField.text!
        newTask.dueDate = dueDatePicker.date
        
        newTask.dateCreated = Date()
        
        taskArr.append(newTask)
        
        didCreateTask = true
        self.navigationController?.popViewController(animated: true)
    }
    
}

extension NewTaskController : UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
