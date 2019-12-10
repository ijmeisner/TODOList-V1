//
//  ToDoListTableViewController.swift
//  project-TheShepherd
//
//  Created by Isaac Meisne on 12/9/19.
//  Copyright © 2019 Isaac Meisne. All rights reserved.
//

import Foundation
import UIKit

class ToDoListTableViewController: UITableViewController {
    
    private var dataSource: [Task] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "TODO List"
        construtDataSource()
    }
    
    private func construtDataSource(){
        dataSource.append(Task(title: "Studying programming", dueDate:Date(), type: .coding))
        dataSource.append(Task(title: "Doing Laundry", dueDate:Date(), type: .housework))
        dataSource.append(Task(title: "Planning Trip to Spain", dueDate:Date(), type: .vacationPlanning))
    }
    
    
    @IBAction func createNewTaskTapped(_ sender: Any) {
        
    }
    
    private func displayEmptyTableView(message: String) {
        
        let infoLabel = UILabel()
        infoLabel.text = message
        infoLabel.textAlignment = .center
        infoLabel.numberOfLines = 0
        infoLabel.font = UIFont(name: "HelveticaNeue-light", size: 20)
        
        tableView.backgroundView = infoLabel
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if dataSource.count == 0 {
            displayEmptyTableView(message: "Create some tasks!")
        } else {
            tableView.backgroundView = nil
        }
        
        return dataSource.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = UITableViewCell()
        
        if let tableViewCell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? TaskTableViewCell {
            let task = dataSource[indexPath.row]
            tableViewCell.confirgureWith(task: task)
            cell = tableViewCell
        }
        
        //tableViewCell.textLabel?.text = dataSource[indexPath.row].title
            
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let taskCreatorViewController = segue.destination as? TaskCreatorViewController {
            taskCreatorViewController.delegate = self
        }
        
        guard let selectedCell = sender as? UITableViewCell else {
            return
        }
        
        guard let selectedIndexPath = tableView.indexPath(for: selectedCell) else {
            return
        }
        
        guard let detailViewController = segue.destination as? DetailViewController else{
            return
        }
        
        detailViewController.task = dataSource[selectedIndexPath.row]
    }
}

extension ToDoListTableViewController: TaskCreatorDelegate {
    func didCreateNewTask(task: Task) {
        print("New Task Detected!")
        dataSource.append(task)
        tableView.reloadData()
    }
}
