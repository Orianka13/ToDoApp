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
    
    //проверим что по тапу на кнопку Добавить открывается новый контроллер
    func testAddNewTaskPresentsNewTaskVC() {
        
        XCTAssertNil(self.sut?.presentedViewController)//проверим что при срабатывании данного метода не открывается ни кской другой контроллер
        guard
            let newTaskButton = self.sut?.navigationItem.rightBarButtonItem,
            let action = newTaskButton.action else {
                XCTFail()
                return
            }
        UIApplication.shared.keyWindow?.rootViewController = self.sut
        
        self.sut?.performSelector(onMainThread: action, with: newTaskButton, waitUntilDone: true)
        XCTAssertNotNil(self.sut?.presentedViewController)
        XCTAssertTrue(self.sut?.presentedViewController is NewTaskViewController)
        
        let newTaskVC = self.sut?.presentedViewController as! NewTaskViewController
        XCTAssertNotNil(newTaskVC.titleTextField)
    }
}
