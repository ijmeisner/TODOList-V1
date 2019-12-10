//
//  TaskCreatorViewController.swift
//  project-TheShepherd
//
//  Created by Isaac Meisne on 12/10/19.
//  Copyright © 2019 Isaac Meisne. All rights reserved.
//

import Foundation
import UIKit

protocol TaskCreatorDelegate {
    func didCreateNewTask(task: Task)
}

class TaskCreatorViewController: UIViewController {
    
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var dueDateTextField: UITextField!
    @IBOutlet weak var taskTypeTextField: UITextField!
    
    @IBOutlet weak var navigationBar: UINavigationBar!
    
    var delegate: TaskCreatorDelegate?
    
    private let taskTypes: [TaskType] = [.coding, .vacationPlanning, .studying, .housework]
    
    private var taskTypePickerView: UIPickerView?
    private var dueDatePicker: UIDatePicker?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBar.delegate = self
        configureTextField()
        configureTapGestureRecognizer()
    }
    
    @IBAction func closeButtonTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func createTaskTapped(_ sender: Any) {
        guard let taskTitle = titleTextField.text, taskTitle.count > 0,
              let taskTypeText = taskTypeTextField.text, taskTypeText.count > 0,
              let dueDateText = dueDateTextField.text, dueDateText.count > 0
        else {
            displayError(errorTitle: "Error", errorMessage: "Missing required attributes.")
            return
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        
        guard let dueDate = dateFormatter.date(from: dueDateText) else {
            displayError(errorTitle: "Invalid Date", errorMessage: "Issue with date.")
            return
        }
        
        guard let taskType = TaskType(rawValue: taskTypeText) else {
            displayError(errorTitle: "Invalid Task Type", errorMessage: "Issue with Task Type.")
            return
        }
        
        let newTask = Task(title: taskTitle, dueDate: dueDate, type: taskType)
        
        delegate?.didCreateNewTask(task: newTask)
        
        dismiss(animated: true, completion: nil)
    }
    
    
    private func displayError(errorTitle: String, errorMessage: String) {
        let errorAlertController = UIAlertController(title: errorTitle, message: errorMessage, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default) { (action) in
            print("THE OK BUTTON HANDLER WAS CALLED")
        }
        
        errorAlertController.addAction(okAction)
        
        present(errorAlertController, animated: true, completion: nil)
    }
    
    private func configureTapGestureRecognizer() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(TaskCreatorViewController.didDetectTap(recognizer:)))
        view.addGestureRecognizer(tapGestureRecognizer)
    }
    
    private func configureTextField() {
        
        taskTypePickerView = UIPickerView()
        
        titleTextField.delegate = self
        dueDateTextField.delegate = self
        
        taskTypeTextField.delegate = self
        taskTypeTextField.inputView = taskTypePickerView
        taskTypePickerView?.delegate = self
        taskTypePickerView?.dataSource = self
        
        dueDatePicker = UIDatePicker()
        dueDatePicker?.datePickerMode = .date
        dueDatePicker?.addTarget(self, action: #selector(TaskCreatorViewController.dateSelected(datePicker:)), for: .valueChanged)
        
        dueDateTextField.inputView = dueDatePicker
        
    }
    
    @objc func didDetectTap(recognizer: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    @objc func dateSelected(datePicker: UIDatePicker){
        //MM/dd/yyyy
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        let formattedDate = dateFormatter.string(from: datePicker.date)
        dueDateTextField.text = formattedDate
        
    }
}

extension TaskCreatorViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return taskTypes.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        taskTypeTextField.text = taskTypes[row].rawValue
        
        view.endEditing(true)
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        let selectedTask = taskTypes[row]
        return selectedTask.rawValue
    }
    
}

extension TaskCreatorViewController: UINavigationBarDelegate {
    func position(for bar: UIBarPositioning) -> UIBarPosition {
        return .topAttached
    }
    
}

extension TaskCreatorViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
