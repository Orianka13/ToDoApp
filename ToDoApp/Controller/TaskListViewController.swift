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
    }
}

