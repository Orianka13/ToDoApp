//
//  TaskManager.swift
//  ToDoApp
//
//  Created by Олеся Егорова on 27.01.2022.
//

import UIKit

class TaskManager {
    
    var tasksCount: Int {
        return self.taskArray.count
    }
    var doneTasksCount: Int {
        return self.doneTaskArray.count
    }
    
    var taskArray = [Task]()
    var doneTaskArray = [Task]()
    
    var tasksUrl: URL {
        let fileURLs = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        guard let documentUrl = fileURLs.first else { fatalError() }
        return documentUrl.appendingPathComponent("tasks.plist")
    }
    
    init() {
        NotificationCenter.default.addObserver(self, selector: #selector(save), name: UIApplication.willResignActiveNotification, object: nil)
        if let data = try? Data(contentsOf: tasksUrl) {
            guard let dictionaries = try? PropertyListSerialization.propertyList(from: data, options: [], format: nil) as? [[String : Any]] else { return }
            
            for dict in dictionaries {
                if let task = Task(dict: dict) {
                    taskArray.append(task)
                }
            }
        }
    }
    
    deinit {
        save()
    }
    
    @objc func save() {
        //превратим все task в словари с помощью map
        let taskDictionaries = self.taskArray.map { $0.dict }
        guard taskDictionaries.count > 0 else {
            try? FileManager.default.removeItem(at: self.tasksUrl)
            return
        }
        let plistData = try? PropertyListSerialization.data(fromPropertyList: taskDictionaries, format: .xml, options: PropertyListSerialization.WriteOptions(0))
        
        try? plistData?.write(to: self.tasksUrl, options: .atomic)
        
    }
    
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
