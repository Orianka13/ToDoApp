//
//  DataProviderTests.swift
//  ToDoAppTests
//
//  Created by Олеся Егорова on 28.01.2022.
//

import XCTest
@testable import ToDoApp

class DataProviderTests: XCTestCase {
    
    var sut: DataProvider?
    var tableView: UITableView?
    
    var controller: TaskListViewController?
    
    override func setUpWithError() throws {
        super.setUp()
        self.sut = DataProvider()
        self.sut?.taskManager = TaskManager()
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        self.controller = storyboard.instantiateViewController(withIdentifier: String(describing: TaskListViewController.self)) as? TaskListViewController
        
        controller?.loadViewIfNeeded()
        
        self.tableView = controller?.tableView
        self.tableView?.dataSource = self.sut
        self.tableView?.delegate = self.sut
    }
    
    override func tearDownWithError() throws {
    }
    
    //проверим что в нашем tableView 2 секции
    func testNumberOfSectionsIsTwo() {
        XCTAssertEqual(self.tableView?.numberOfSections, 2)
    }
    
    //проверим что количесвто задач которые нужно выполнить равно количеству строк в секции
    func testNumberOfRowsInSectionZeroAsTaskCount() {
        
        self.sut?.taskManager?.add(task: Task(title: "Foo"))
        
        XCTAssertEqual(self.tableView?.numberOfRows(inSection: 0), 1)
        
        self.sut?.taskManager?.add(task: Task(title: "Bar"))
        
        self.tableView?.reloadData()
        
        XCTAssertEqual(self.tableView?.numberOfRows(inSection: 0), 2)
        
    }
    
    func testNumberOfRowsInSectionOneDoneTaskCount() {
        
        self.sut?.taskManager?.add(task: Task(title: "Foo"))
        self.sut?.taskManager?.add(task: Task(title: "Bar"))
        
        self.sut?.taskManager?.checkTask(at: 0)
        
        XCTAssertEqual(self.tableView?.numberOfRows(inSection: 1), 1)
        
        self.sut?.taskManager?.checkTask(at: 0)
        
        self.tableView?.reloadData()
        
        XCTAssertEqual(self.tableView?.numberOfRows(inSection: 1), 2)
    }
    
    //проверим какую ячейкуп олучаем в методе cellForRowAt
    func testCellForRowAtIndexPathReturnsTaskCell() {
        self.sut?.taskManager?.add(task: Task(title: "Foo"))
        self.tableView?.reloadData()
        let cell = tableView?.cellForRow(at: IndexPath(row: 0, section: 0))
        XCTAssertTrue(cell is TaskCell)
    }
    
    //проверим переиспользуем мы ячейку или нет
    func testCellForRowAtIndexPathDequesCellFromTableView() {
        let mockTableView = MockTableView.mockTableView(withDataSource: self.sut!)
        
        self.sut?.taskManager?.add(task: Task(title: "Foo"))
        mockTableView.reloadData()
        _ = mockTableView.cellForRow(at: IndexPath(row: 0, section: 0))
        XCTAssertTrue(mockTableView.cellIsDequed)
    }
    
    //проверим срабатывает ли метод configure в первой секции
    func testCellForRowInSectionZeroCallsConfigure() {
        let mockTableView = MockTableView.mockTableView(withDataSource: self.sut!)
        
        let task = Task(title: "Foo")
        self.sut?.taskManager?.add(task: task)
        mockTableView.reloadData()
        let cell = mockTableView.cellForRow(at: IndexPath(row: 0, section: 0)) as! MockTaskCell
        
        XCTAssertEqual(task, cell.task)
    }
    
    func testCellForRowInSectionOneCallsConfigure() {
        let mockTableView = MockTableView.mockTableView(withDataSource: self.sut!)
    
        let task = Task(title: "Foo")
        let task2 = Task(title: "Bar")
        self.sut?.taskManager?.add(task: task)
        self.sut?.taskManager?.add(task: task2)
        self.sut?.taskManager?.checkTask(at: 0)
        
        mockTableView.reloadData()
        
        let cell = mockTableView.cellForRow(at: IndexPath(row: 0, section: 1)) as! MockTaskCell
        
        XCTAssertEqual(task, cell.task)
    }
    
    //проверим что в первой секции по свайпу открывается менюшка удаления
    func testDeleteButtonTitleSectionZeroShowsDone() {
        guard let tableView = self.tableView else { return }
        let buttonTitle = tableView.delegate?.tableView?(tableView, titleForDeleteConfirmationButtonForRowAt: IndexPath(row: 0, section: 0))
        XCTAssertEqual(buttonTitle, "Done")
    }
    
    func testDeleteButtonTitleSectionOneShowsDone() {
        guard let tableView = self.tableView else { return }
        let buttonTitle = tableView.delegate?.tableView?(tableView, titleForDeleteConfirmationButtonForRowAt: IndexPath(row: 0, section: 1))
        XCTAssertEqual(buttonTitle, "Undone")
    }
    
    //проверим что при нажатии на кнопку done/undone таски перебрасываются из секции в секцию
    func testCheckingTaskChecksInTaskManager() {
        let task = Task(title: "Bar")
        self.sut?.taskManager?.add(task: task)
        guard let tableView = self.tableView else { return }
        tableView.dataSource?.tableView?(tableView, commit: .delete, forRowAt: IndexPath(row: 0, section: 0))
        XCTAssertEqual(self.sut?.taskManager?.tasksCount, 0)
        XCTAssertEqual(self.sut?.taskManager?.doneTasksCount, 1)
    }
    func testUncheckingTaskUnchecksInTaskManager() {
        let task = Task(title: "Bar")
        self.sut?.taskManager?.add(task: task)
        self.sut?.taskManager?.checkTask(at: 0)
        
        guard let tableView = self.tableView else { return }
        tableView.reloadData()
        
        tableView.dataSource?.tableView?(tableView, commit: .delete, forRowAt: IndexPath(row: 0, section: 1))
        
        XCTAssertEqual(self.sut?.taskManager?.tasksCount, 1)
        XCTAssertEqual(self.sut?.taskManager?.doneTasksCount, 0)
    }
}


//подменим наш обычный tableView MockTableView где укажем дополнительное свойство которое подскажет использовалась ли ячейка
extension DataProviderTests {
    class MockTableView: UITableView { //создаем класс внутри расширения чтобы ограничить его степень видимости
        var cellIsDequed = false
        
        static func mockTableView(withDataSource dataSource: UITableViewDataSource) -> MockTableView {
            let mockTableView = MockTableView(frame: CGRect(x: 0, y: 0, width: 375, height: 658), style: .plain) //если не указать размеры то по дефолту будет 0:0 и учитывается только одна секция
            
            mockTableView.dataSource = dataSource
            mockTableView.register(MockTaskCell.self, forCellReuseIdentifier: String(describing: TaskCell.self))
            
            return mockTableView
        }
        
        override func dequeueReusableCell(withIdentifier identifier: String, for indexPath: IndexPath) -> UITableViewCell {
            self.cellIsDequed = true
            return super.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        }
    }
    
    //сделаем мок для ячейки
    class MockTaskCell: TaskCell {
        var task: Task?
        
        override func configure(withTask task: Task, done: Bool = false) {
            self.task = task
            
        }
    }
}
