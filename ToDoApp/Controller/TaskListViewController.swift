//
//  ViewController.swift
//  ToDoApp
//
//  Created by Олеся Егорова on 04.11.2021.
//

import UIKit

class TaskListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet var dataProvider: DataProvider!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let taskManager = TaskManager()
        self.dataProvider.taskManager = taskManager
    }
    @IBAction func addNewTask(_ sender: UIBarButtonItem) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: String(describing: NewTaskViewController.self)) as? NewTaskViewController {
            vc.taskManager = self.dataProvider.taskManager
            present(vc, animated: true, completion: nil)
        }
    }
}

