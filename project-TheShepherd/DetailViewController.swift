//
//  DetailViewController.swift
//  project-TheShepherd
//
//  Created by Isaac Meisne on 12/9/19.
//  Copyright © 2019 Isaac Meisne. All rights reserved.
//

import Foundation
import UIKit

class DetailViewController: UIViewController {
    
    
    
    @IBOutlet weak var taskTitleLabel: UILabel!
    @IBOutlet weak var taskDueDateLabel: UILabel!
    @IBOutlet weak var taskTypeLabel: UILabel!
    
    var task: Task?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureInterface()
        title = "Task Detail"
    }
    
    private func configureInterface (){
        if let task = task {
            taskTitleLabel.text = task.title
            taskTypeLabel.text = task.type.rawValue
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MM/dd/yyyy"
            
            
            taskDueDateLabel.text = dateFormatter.string(from: task.dueDate)
            
        }
    }
    
}
