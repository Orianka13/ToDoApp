//
//  DataProvider.swift
//  ToDoApp
//
//  Created by Олеся Егорова on 28.01.2022.
//

import UIKit

enum Section: Int, CaseIterable {
    case todo
    case done
}

final class DataProvider: NSObject {
    var taskManager: TaskManager?
}

//MARK: UITableViewDelegate
extension DataProvider: UITableViewDelegate {
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        guard let section = Section(rawValue: indexPath.section) else { fatalError() }
        switch section {
        case .todo:
            return "Done"
        case .done:
            return "Undone"
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let section = Section(rawValue: indexPath.section) else { fatalError() }
        switch section {
        case .todo:
            let task = taskManager?.task(at: indexPath.row)
            NotificationCenter.default.post(name: NSNotification.Name("Did select row notification"), object: self, userInfo: ["task": task])
        case .done:
            break
        }
    }
}

//MARK: UITableViewDataSource
extension DataProvider: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return Section.allCases.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        guard let section = Section(rawValue: section) else { fatalError() }
        guard let taskManager = self.taskManager else { return 0 }
        switch section {
        case .todo:
            return taskManager.tasksCount
        case .done:
            return taskManager.doneTasksCount
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: TaskCell.self), for: indexPath) as! TaskCell

        let task: Task
        guard let section = Section(rawValue: indexPath.section) else { fatalError() }
        guard let taskManager = self.taskManager else { return TaskCell() }

        switch section {
        case .todo:
            task = taskManager.task(at: indexPath.row)
        case .done:
            task = taskManager.doneTask(at: indexPath.row)
        }
        cell.configure(withTask: task)

        return cell
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {

        guard let section = Section(rawValue: indexPath.section) else { fatalError() }
        guard let taskManager = self.taskManager else { return }

        switch section {
        case .todo:
            taskManager.checkTask(at: indexPath.row)
        case .done:
            taskManager.uncheckTask(at: indexPath.row)
        }

        tableView.reloadData()
    }
}

