//
//  TaskCellTests.swift
//  ToDoAppTests
//
//  Created by Олеся Егорова on 09.03.2022.
//

import XCTest
@testable import ToDoApp

class TaskCellTests: XCTestCase {
    
    var cell: TaskCell!
    
    override func setUpWithError() throws {
        super.setUp()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: String(describing: TaskListViewController.self)) as! TaskListViewController
        controller.loadViewIfNeeded()
        
        let tableView = controller.tableView
        let dataSource = FakeDataSource()
        tableView?.dataSource = dataSource
        
        self.cell = tableView?.dequeueReusableCell(withIdentifier: String(describing: TaskCell.self), for: IndexPath(row: 0, section: 0)) as? TaskCell
    }
    
    override func tearDownWithError() throws {
    }
    
    //проверим есть и у ячейки заголовок
    func testCellHasTitleLable() {
        XCTAssertNotNil(self.cell.titleLabel)
    }
    
    //проверим действительно ли titleLable находится внутри вью
    func testCellHasTitleLableInContentView() {
        XCTAssertTrue(self.cell.titleLabel.isDescendant(of: self.cell.contentView))
    }
    
    //проверим есть и у ячейки ярлык Локация
    func testCellHasLocationLable() {
        XCTAssertNotNil(self.cell.locationLabel)
    }
    
    //проверим действительно ли locationLabel находится внутри вью
    func testCellHasLocationLableInContentView() {
        XCTAssertTrue(self.cell.locationLabel.isDescendant(of: self.cell.contentView))
    }
    
    //проверим есть и у ячейки ярлык dateLabel
    func testCellHasDateLable() {
        XCTAssertNotNil(self.cell.dateLabel)
    }
    
    //проверим действительно ли DateLabel находится внутри вью
    func testCellHasDateLableInContentView() {
        XCTAssertTrue(self.cell.dateLabel.isDescendant(of: self.cell.contentView))
    }
    
    //проверим что метод configure устанавливает заголовок в нашу ячейку
    func testConfigureSetsTitle() {
        
        let task = Task(title: "Foo")
        self.cell.configure(withTask: task)
        
        XCTAssertEqual(self.cell.titleLabel.text, task.title)
    }
    
    //проверим что метод configure устанавливает дату в нашу ячейку
    func testConfigureSetsDate() {
        let task = Task(title: "Foo")
        self.cell.configure(withTask: task)
        
        let df = DateFormatter()
        df.dateFormat = "dd.MM.yy" // http://nsdateformatter.com
        let date = task.date
        let dateString = df.string(from: date!)
        
        XCTAssertEqual(self.cell.dateLabel.text, dateString)
    }
    
    //проверим что метод configure устанавливает location в нашу ячейку
    func testConfigureSetsLocation() {
        let location = Location(name: "Bar")
        let task = Task(title: "Foo", location: location)
        self.cell.configure(withTask: task)
        
        XCTAssertEqual(self.cell.locationLabel.text, task.location?.name)
    }
    
    func configureCellWithDoneTask() {
        let task = Task(title: "Foo")
        self.cell.configure(withTask: task, done: true)
    }
    
    //проверим что выполненные задачи зачеркнуты
    func testDoneTaskShouldStrikeTrough() {
        self.configureCellWithDoneTask()

        let attributedString = NSAttributedString(string: "Foo", attributes: [NSAttributedString.Key.strikethroughStyle : NSUnderlineStyle.single.rawValue])
        XCTAssertEqual(self.cell.titleLabel.attributedText, attributedString)
    }
    //проверим что у выполненных задач дата скрыта
    func testDoneTaskDateLabelEqualsNil() {
        self.configureCellWithDoneTask()
        
        XCTAssertNil(self.cell.dateLabel)
    }
    
    //проверим что у выполненных задач локация скрыта
    func testDoneTaskLocationLabelEqualsNil() {
        self.configureCellWithDoneTask()
        
        XCTAssertNil(self.cell.locationLabel)
    }
}

extension TaskCellTests {
    class FakeDataSource: NSObject, UITableViewDataSource {
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return 1
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            return UITableViewCell()
        }
    }
}
