//
//  ToDoAppUITests.swift
//  ToDoAppUITests
//
//  Created by Олеся Егорова on 04.11.2021.
//

import XCTest

class ToDoAppUITests: XCTestCase {

    var app: XCUIApplication!
    
    override func setUpWithError() throws {
        continueAfterFailure = false
        
        app = XCUIApplication()
        app.launchArguments.append("--UITesting")
        app.launch()
    }

    override func tearDownWithError() throws {
        
    }

    func testExample() throws {

        XCTAssertTrue(app.isOnMainView)
        
        app.navigationBars["ToDoApp.TaskListView"].buttons["Add"].tap()
        app.textFields["Title"].tap()
        app.textFields["Title"].typeText("Foo")
        
        let locationTextField = app.textFields["Location"]
        locationTextField.tap()
        locationTextField.typeText("Bar")
        
        let dateTextField = app.textFields["Date"]
        dateTextField.tap()
        dateTextField.typeText("20.03.22")
        
        let addressTextField = app.textFields["Address"]
        addressTextField.tap()
        addressTextField.typeText("Санкт-Петербург")
        
        let descriptionTextField = app.textFields["Description"]
        descriptionTextField.tap()
        descriptionTextField.typeText("Baz")
       
        //XCTAssertFalse(app.isOnMainView)
        
        app/*@START_MENU_TOKEN@*/.buttons["Save"].staticTexts["Save"]/*[[".buttons[\"Save\"].staticTexts[\"Save\"]",".staticTexts[\"Save\"]"],[[[-1,1],[-1,0]]],[1]]@END_MENU_TOKEN@*/.tap()
        
//        XCTAssertTrue(app.tables.staticTexts["Foo"].exists)
//        XCTAssertTrue(app.tables.staticTexts["Bar"].exists)
//        XCTAssertTrue(app.tables.staticTexts["20.03.22"].exists)
  
    }
    
//    func testWhenCellIsSwipedLeftDoneButtonAppeared() {
//        XCTAssertTrue(app.isOnMainView)
//
//        app.navigationBars["ToDoApp.TaskListView"].buttons["Add"].tap()
//        app.textFields["Title"].tap()
//        app.textFields["Title"].typeText("Foo")
//
//        let locationTextField = app.textFields["Location"]
//        locationTextField.tap()
//        locationTextField.typeText("Bar")
//
//        let dateTextField = app.textFields["Date"]
//        dateTextField.tap()
//        dateTextField.typeText("20.03.22")
//
//        let addressTextField = app.textFields["Address"]
//        addressTextField.tap()
//        addressTextField.typeText("Санкт-Петербург")
//
//        let descriptionTextField = app.textFields["Description"]
//        descriptionTextField.tap()
//        descriptionTextField.typeText("Baz")
//
//        XCTAssertFalse(app.isOnMainView)
//        app.buttons["Save"].staticTexts["Save"].tap()
//
//        XCTAssertTrue(app.isOnMainView)
//
//        let tablesQuery = app.tables.cells
//        tablesQuery.element(boundBy: 0).swipeLeft()
//        tablesQuery.element(boundBy: 0).buttons["Done"].tap()
//
//        XCTAssertEqual(app.staticTexts.element(matching: .any, identifier: "date").label, "")
//
//
//    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}


extension XCUIApplication {
    var isOnMainView: Bool {
        return otherElements["mainView"].exists
    }
}
