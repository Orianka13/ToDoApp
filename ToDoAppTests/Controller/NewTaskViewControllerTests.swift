//
//  NewTaskViewControllerTests.swift
//  ToDoAppTests
//
//  Created by Олеся Егорова on 10.03.2022.
//

import XCTest
@testable import ToDoApp

class NewTaskViewControllerTests: XCTestCase {
    
    var controller: NewTaskViewController!

    override func setUpWithError() throws {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        self.controller = storyboard.instantiateViewController(withIdentifier: String(describing: NewTaskViewController.self)) as? NewTaskViewController
        
        self.controller.loadViewIfNeeded()
    }

    override func tearDownWithError() throws {
    }
    
    func testHasTitleTextField() {
        XCTAssertTrue(self.controller.titleTextField.isDescendant(of: self.controller.view))
    }
    func testHasLocationTextField() {
        XCTAssertTrue(self.controller.locationTF.isDescendant(of: self.controller.view))
    }
    func testHasDateTextField() {
        XCTAssertTrue(self.controller.dateTF.isDescendant(of: self.controller.view))
    }
    func testHasAddressTextField() {
        XCTAssertTrue(self.controller.addressTF.isDescendant(of: self.controller.view))
    }
    func testHasDescriptionTextField() {
        XCTAssertTrue(self.controller.descriptionTF.isDescendant(of: self.controller.view))
    }
    func testHasSaveButton() {
        XCTAssertTrue(self.controller.saveButton.isDescendant(of: self.controller.view))
    }
    func testHasCancelButton() {
        XCTAssertTrue(self.controller.cancelButton.isDescendant(of: self.controller.view))
    }
    

}
