//
//  ToDoAppTests.swift
//  ToDoAppTests
//
//  Created by Олеся Егорова on 04.11.2021.
//

import XCTest
@testable import ToDoApp

class ToDoAppTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testInitialViewControllerIsTaskListViewController() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let navigationVC = storyboard.instantiateInitialViewController() as? UINavigationController
        guard let rootVC = navigationVC?.viewControllers.first as? TaskListViewController else {
            print("No NavigationVC")
            return
        }
        
        XCTAssertTrue(rootVC is TaskListViewController)
        
    }

}
