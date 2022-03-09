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
}

extension TaskCellTests {
    //для ячейки создаем фейковую dataSource
    class FakeDataSource: NSObject, UITableViewDataSource {
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return 1
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            return UITableViewCell()
        }
    }
}
