//
//  DetailViewControllerTests.swift
//  ToDoAppTests
//
//  Created by Олеся Егорова on 09.03.2022.
//

import XCTest
@testable import ToDoApp
import CoreLocation

class DetailViewControllerTests: XCTestCase {
    
    var controller: DetailViewController!
    var task: Task!
    
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
    
    func testHasLocationLabel() {
        XCTAssertNotNil(self.controller.locationLabel)
        XCTAssertTrue(self.controller.locationLabel.isDescendant(of: self.controller.view))
        
    }
    
    //проверим есть ли MapKit на DetailViewController
    func testHasMapView() {
        XCTAssertNotNil(self.controller.mapView)
        XCTAssertTrue(self.controller.mapView.isDescendant(of: self.controller.view))
        
    }
    
    func setupTaskAndAppearanceTransition() {
        
        let coordinate = CLLocationCoordinate2D(latitude: 59.88304167, longitude: 30.38266797)
        let location = Location(name: "Baz", coordinate: coordinate)
        let date = Date(timeIntervalSince1970: 1646895570)
        self.task = Task(title: "Foo", description: "Bar", date: date, location: location)
        self.controller.task = self.task
        
        self.controller.beginAppearanceTransition(true, animated: true) //имитируем viewWillAppear
        self.controller.endAppearanceTransition() // viewDidAppear
        
    }
    
    //проверим что наши ярлыки размещают в себе необходимую информацию по конкретному task
    func testSettingTaskSetsTitleLabel(){
        
        self.setupTaskAndAppearanceTransition()
        XCTAssertEqual(self.controller.titleLabel.text, "Foo")
    }
    
    func testSettingTaskSetsDescriptionLabel(){
        
        self.setupTaskAndAppearanceTransition()
        XCTAssertEqual(self.controller.descriptionLabel.text, "Bar")
    }
    
    func testSettingTaskSetsDateLabel() {
        
        self.setupTaskAndAppearanceTransition()
        let df = DateFormatter()
        df.dateFormat = "dd.MM.yy"
        if let date = self.task.date {
            let stringDate = df.string(from: date)
            XCTAssertEqual(self.controller.dateLabel.text, stringDate)
        }
    }
    
    func testSettingTaskSetsLocationNameLabel(){
        
        self.setupTaskAndAppearanceTransition()
        XCTAssertEqual(self.controller.locationLabel.text, "Baz")
    }
    
}
