//
//  TaskListViewControllerTests.swift
//  ToDoAppTests
//
//  Created by Олеся Егорова on 28.01.2022.
//

import XCTest
@testable import ToDoApp

class TaskListViewControllerTests: XCTestCase {
    
    private var sut: TaskListViewController?
    
    override func setUpWithError() throws {
        super.setUp()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let vc = storyboard.instantiateViewController(withIdentifier: String(describing: TaskListViewController.self))
        self.sut = vc as? TaskListViewController
        _ = self.sut?.view //sut.loadViewIfNeeded()
    }
    
    override func tearDownWithError() throws {
    }
    
    //проверим имеет ли наш VC после загрузки внутри себя TableView
    func testTableViewNotNillWhenViewIsLoaded() {
        XCTAssertNotNil(self.sut?.tableView)
    }
    //проверим наличие data provider после того как наш VC загрузился
    //dataProvider нужен дл того чтобы отдать всю логику по tableView в него разгрузив наш VC
    func testWhenViewIsLoadedDataProviderIsNotNill() {
        XCTAssertNotNil(self.sut?.dataProvider)
    }
    
    //проверить что при загрузке контроллера делегат для tableView будет установлен
    func testWhenViewIsLoadedTableViewDelegateIsSet() {
        XCTAssertTrue(self.sut?.tableView.delegate is DataProvider)
    }
    
    func testWhenViewIsLoadedTableViewDataSourceIsSet() {
        XCTAssertTrue(self.sut?.tableView.dataSource is DataProvider)
    }
    
    //проверим что все протоколы по таблице реализует dataProvider
    func testWhenViewIsLoadedTVDelegateEqualsTVDataSource() {
        XCTAssertEqual(self.sut?.tableView.delegate as? DataProvider,
                       self.sut?.tableView.dataSource as? DataProvider)
    }
    
    //проверим что есть кнопка добавить задачу
    func testTaskListVCHasAddBarButtonWithSelfAsTarget() {
        let target = self.sut?.navigationItem.rightBarButtonItem?.target
        XCTAssertEqual(target as? TaskListViewController, self.sut)
    }
    
    func setNewTaskVC() -> NewTaskViewController {
        guard
            let newTaskButton = self.sut?.navigationItem.rightBarButtonItem,
            let action = newTaskButton.action else {
                return NewTaskViewController()
            }
        UIApplication.shared.keyWindow?.rootViewController = self.sut
        
        self.sut?.performSelector(onMainThread: action, with: newTaskButton, waitUntilDone: true)
        
        let newTaskVC = self.sut?.presentedViewController as! NewTaskViewController
        
        return newTaskVC
    }
    
    //проверим что по тапу на кнопку Добавить открывается новый контроллер
    func testAddNewTaskPresentsNewTaskVC() {
        
        let newTaskVC = setNewTaskVC()
        
        XCTAssertNotNil(newTaskVC.titleTextField)
    }
    
    //проверим что у датаПровайдера и NewTaskVC один таск менеджер
    func testSharesSameTaskManagerWithNewTaskVC() {
        
        let newTaskVC = setNewTaskVC()
        
        XCTAssertNotNil(self.sut?.dataProvider.taskManager)
        XCTAssertTrue(newTaskVC.taskManager === self.sut?.dataProvider.taskManager)
    }
    
    //когда появляется вью перегружаем tableView
    func testWhenViewAppearedTableViewReloaded() {
        let mockTableView = MockTableView()
        self.sut?.tableView = mockTableView
        
        self.sut?.beginAppearanceTransition(true, animated: true)
        self.sut?.endAppearanceTransition()
        
        XCTAssertTrue((self.sut?.tableView as! MockTableView).isReloaded)
    }
    
    func testTappingCellSendsNotification() {
        let task = Task(title: "Foo")
        self.sut?.dataProvider.taskManager?.add(task: task)
        expectation(forNotification: NSNotification.Name("Did select row notification"), object: nil) { notification in
            guard let taskNotification = notification.userInfo?["task"] as? Task else { return false }
            return task == taskNotification
        }
        let tableView = sut?.tableView
        tableView?.delegate?.tableView?(tableView!, didSelectRowAt: IndexPath(row: 0, section: 0))
        waitForExpectations(timeout: 1, handler: nil)
    }
}

extension TaskListViewControllerTests {
    class MockTableView: UITableView {
        var isReloaded = false
        override func reloadData() {
            self.isReloaded = true
        }
    }
}
