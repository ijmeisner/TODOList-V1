//
//  Task.swift
//  project-TheShepherd
//
//  Created by Isaac Meisne on 12/9/19.
//  Copyright © 2019 Isaac Meisne. All rights reserved.
//

import Foundation

class Task {
    let title: String
    let dueDate: Date
    let type: TaskType
    
    init(title: String, dueDate: Date, type: TaskType) {
        self.title = title
        self.dueDate = dueDate
        self.type = type
    }
    
}
