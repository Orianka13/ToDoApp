//
//  ViewController.swift
//  ToDoApp
//
//  Created by Олеся Егорова on 04.11.2021.
//

import UIKit

class TaskListViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    @IBOutlet var dataProvider: DataProvider!
    
    @IBAction func addNewTask(_ sender: UIBarButtonItem) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: String(describing: NewTaskViewController.self)) as? NewTaskViewController {
            vc.taskManager = self.dataProvider.taskManager
            //self.navigationController?.present(vc, animated: true, completion: nil)
            present(vc, animated: true, completion: nil)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let taskManager = TaskManager()
        self.dataProvider.taskManager = taskManager
        
        self.view.backgroundColor = .white
        self.tableView.backgroundColor = .green
        
        NotificationCenter.default.addObserver(self, selector: #selector(showDetail(withNotification:)), name: NSNotification.Name("DidSelectRow notification"), object: nil)
        
        view.accessibilityIdentifier = "mainView"
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.reloadData()
        print("Created task: \(self.dataProvider.taskManager?.taskArray.first)")
    }
    
    @objc func showDetail(withNotification notification: Notification) {
        guard
            let userInfo = notification.userInfo,
            let task = userInfo["task"] as? Task,
            let detailVC = storyboard?.instantiateViewController(withIdentifier: String(describing: DetailViewController.self)) as? DetailViewController
        else { return }
        detailVC.task = task
        navigationController?.pushViewController(detailVC, animated: true)
        
    }
}
