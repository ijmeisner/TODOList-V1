//
//  TaskTableViewCell.swift
//  project-TheShepherd
//
//  Created by Isaac Meisne on 12/10/19.
//  Copyright © 2019 Isaac Meisne. All rights reserved.
//

import Foundation
import UIKit

class TaskTableViewCell: UITableViewCell {
    
    @IBOutlet weak var taskTitle: UILabel!
    @IBOutlet weak var taskSubtitle: UILabel!
    func confirgureWith(task: Task) {
        taskTitle.text = task.title
        taskSubtitle.text = "Type: \(task.type.rawValue)"
        
    }
}
