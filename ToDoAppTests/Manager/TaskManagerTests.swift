//
//  TaskManagerTests.swift
//  ToDoAppTests
//
//  Created by Олеся Егорова on 27.01.2022.
//

import XCTest
@testable import ToDoApp

class TaskManagerTests: XCTestCase {

    private var sut: TaskManager? //sut - system under test - TaskManager
    
    override func setUpWithError() throws {
        self.sut = TaskManager()
    }

    override func tearDownWithError() throws {
        self.sut?.removeAll()
        self.sut = nil
        try super.tearDownWithError()
    }
//проверяем что у менеджера нет выполненных и не выполненых задач
    func testInitTaskManagerWithZeroTasks(){
        //проверяем сколько задач перед нами стоит
        XCTAssertEqual(self.sut?.tasksCount, 0)
    }
    
    func testInitTaskManagerWithZeroDoneTasks(){
        XCTAssertEqual(self.sut?.doneTasksCount, 0)
    }
//проверяем что при добавлении задачи наш tasksCount увеличится на единицу
    func testAddTaskIncrementTasksCount() {
        let task = Task(title: "Foo")
        self.sut?.add(task: task)
        XCTAssertEqual(self.sut?.tasksCount, 1)
    }
    
    //проверим что добавленный таск соответствует таску по индексу
    func testTaskAtIndexIsAddedTask() {
        let task = Task(title: "Foo")
        self.sut?.add(task: task)
        let returnedTask = self.sut?.task(at: 0)
        XCTAssertEqual(task.title, returnedTask?.title)
    }
    
    //проверим что выполняя задачу их количесвто меняется
    func testCheckTaskAtIndexChangesCounts() {
        let task = Task(title: "Foo")
        self.sut?.add(task: task)
        self.sut?.checkTask(at: 0)
        XCTAssertEqual(sut?.tasksCount, 0)
        XCTAssertEqual(sut?.doneTasksCount, 1)
    }
    
    //проверим что выполненные задачи удаляются из массива
    func testCheckedTaskRemoveFromArray() {
        let firstTask = Task(title: "Foo")
        let secondTask = Task(title: "Bar")
        self.sut?.add(task: firstTask)
        self.sut?.add(task: secondTask)
        
        self.sut?.checkTask(at: 0)
        
        XCTAssertEqual(self.sut?.task(at: 0), secondTask)
    }
    
    //выполненая задача попадает в свой массив выполненных задач
    func testDoneTaskAtReturnsCheckedTask() {
        let task = Task(title: "Foo")
        self.sut?.add(task: task)
        self.sut?.checkTask(at: 0)
        
        let returnedTask = self.sut?.doneTask(at: 0)
        XCTAssertEqual(task, returnedTask)
    }
    
    //метод который удаляет элементы из двух массивов
    func testRemoveAllResultsCountsBeZero() {
        self.sut?.add(task: Task(title: "Foo"))
        self.sut?.add(task: Task(title: "Bar"))
        self.sut?.checkTask(at: 0)
        self.sut?.removeAll()
        XCTAssertTrue(self.sut?.tasksCount == 0)
        XCTAssertTrue(self.sut?.doneTasksCount == 0)
    }
    
    //проверим что в массиве хранятся только уникальные значения
    func testAddingSameObjectDoesNotIncrementCount() {
        self.sut?.add(task: Task(title: "Foo"))
        self.sut?.add(task: Task(title: "Foo"))
        XCTAssertTrue(self.sut?.tasksCount == 1)
    }
    
    //проверим что после сохранения TaskManager выгружает верные задачи
    func testWhenTaskManagerRecreatedSavedTasksShouldBeEqual() {
        var taskManager: TaskManager! = TaskManager()
        let task = Task(title: "Foo")
        let task1 = Task(title: "Bar")
        
        taskManager.add(task: task)
        taskManager.add(task: task1)
        
        NotificationCenter.default.post(name: UIApplication.willResignActiveNotification, object: nil)
        
        taskManager = nil
        taskManager = TaskManager()
        
        XCTAssertEqual(taskManager.tasksCount, 2)
        XCTAssertEqual(taskManager.task(at: 0), task)
        XCTAssertEqual(taskManager.task(at: 1), task1)
    }
    
    //проверим что свойство isDone меняется в зависимости от выполнения задач
//    func testDoneTaskIsDonetoggled() {
//        let task = Task(title: "Foo")
//        self.sut?.add(task: task)
//        self.sut?.checkTask(at: 0)
//
//        XCTAssertEqual(task.isDone, true)
//    }
    
    func testUndoneTaskIsDonetoggled() {
        let task = Task(title: "Foo")
        self.sut?.add(task: task)
        self.sut?.checkTask(at: 0)
        self.sut?.uncheckTask(at: 0)
        XCTAssertEqual(task.isDone, false)
    }
}
