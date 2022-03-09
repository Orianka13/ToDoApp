//
//  TaskManager.swift
//  ToDoApp
//
//  Created by Олеся Егорова on 27.01.2022.
//

import Foundation

class TaskManager {
    var tasksCount: Int {
        return self.taskArray.count
    }
    var doneTasksCount: Int {
        return self.doneTaskArray.count
    }
    
    var taskArray = [Task]()
    var doneTaskArray = [Task]()
    
    func add(task: Task) {
        if !taskArray.contains(task) {
            self.taskArray.append(task)
        }
    }
    
    func task(at index: Int) -> Task {
        return self.taskArray[index]
    }
    
    func doneTask(at index: Int) -> Task {
        return self.doneTaskArray[index]
    }
    
    func checkTask(at index: Int) {
        let checkedTask = self.taskArray.remove(at: index)
        self.doneTaskArray.append(checkedTask)
    }
    
    func uncheckTask(at index: Int) {
        let uncheckedTask = self.doneTaskArray.remove(at: index)
        self.taskArray.append(uncheckedTask)
    }
    
    func removeAll() {
        self.taskArray.removeAll()
        self.doneTaskArray.removeAll()
    }
}
