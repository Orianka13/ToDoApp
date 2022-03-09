//
//  DetailViewControllerTests.swift
//  ToDoAppTests
//
//  Created by Олеся Егорова on 09.03.2022.
//

import XCTest
@testable import ToDoApp

class DetailViewControllerTests: XCTestCase {
    
    var controller: DetailViewController!
    
    override func setUpWithError() throws {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        self.controller = storyboard.instantiateViewController(withIdentifier: String(describing: DetailViewController.self)) as? DetailViewController
        
        self.controller.loadViewIfNeeded()
    }
    
    override func tearDownWithError() throws {
        
    }
    
    //проверим что в DetailViewController есть titleLabel
    func testHasTitleLabel() {
        XCTAssertNotNil(self.controller.titleLabel)
        XCTAssertTrue(self.controller.titleLabel.isDescendant(of: self.controller.view))
        
    }
    
    func testHasDescriptionLabel() {
        XCTAssertNotNil(self.controller.descriptionLabel)
        XCTAssertTrue(self.controller.descriptionLabel.isDescendant(of: self.controller.view))
        
    }
    
    func testHasDateLabel() {
        XCTAssertNotNil(self.controller.dateLabel)
        XCTAssertTrue(self.controller.dateLabel.isDescendant(of: self.controller.view))
        
    }
    
    //проверим есть ли MapKit на DetailViewController
    func testHasMapView() {
        XCTAssertNotNil(self.controller.mapView)
        XCTAssertTrue(self.controller.mapView.isDescendant(of: self.controller.view))
        
    }
}
