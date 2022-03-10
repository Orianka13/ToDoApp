//
//  NewTaskViewControllerTests.swift
//  ToDoAppTests
//
//  Created by Олеся Егорова on 10.03.2022.
//

import XCTest
import CoreLocation
@testable import ToDoApp

class NewTaskViewControllerTests: XCTestCase {
    
    var controller: NewTaskViewController!
    var placemark: MockCLPlacemark!
    
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
    
    //проверим что при вводе адреса он трансформируется с помощью геокодера в координаты
    func testSaveUsesGeocoderToConvertCoordinateFromAddress() {
        let df = DateFormatter()
        df.dateFormat = "dd.MM.yy"
        let date = df.date(from: "10.03.22")
        
        self.controller.titleTextField.text = "Foo"
        self.controller.locationTF.text = "Bar"
        self.controller.dateTF.text = "10.03.22"
        self.controller.addressTF.text = "Санкт-Петербург"
        self.controller.descriptionTF.text = "Baz"
        
        self.controller.taskManager = TaskManager()
        let mockGeocoder = MockCLGeocoder()
        self.controller.geocoder = mockGeocoder
        
        self.controller.save()
        
        
        let coordinate = CLLocationCoordinate2D(latitude: 59.9342562, longitude: 30.3351228) //Санкт-Петербург через Geocoder
        let location = Location(name: "Bar", coordinate: coordinate)
        
        let generatedTask = Task(title: "Foo", description: "Baz", date: date, location: location)
        
        self.placemark = MockCLPlacemark()
        self.placemark.mockCoordinate = coordinate
        
        mockGeocoder.completionHandler?([placemark], nil)
        
        let task = self.controller.taskManager.task(at: 0)
        
        XCTAssertEqual(task, generatedTask)
        
    }
    
    //проверим что функция save привязана к кнопке save
    func testSaveButtonHasSaveMethod() {
        let saveButton = self.controller.saveButton
        guard let actions = saveButton?.actions(forTarget: self.controller, forControlEvent: .touchUpInside) else {
            XCTFail()
            return
        }
        XCTAssertTrue(actions.contains("save"))
        
    }
}

extension NewTaskViewControllerTests {
    //чтобы исключить наличие интернета создадим фейковый класс для геокодера
    class MockCLGeocoder: CLGeocoder {
        //вытащим completionHandler чтобы использовать его в тот момент когда это будет удобно
        var completionHandler: CLGeocodeCompletionHandler?
        
        override func geocodeAddressString(_ addressString: String, completionHandler: @escaping CLGeocodeCompletionHandler) {
            self.completionHandler = completionHandler
        }
    }
    
    class MockCLPlacemark: CLPlacemark {
        
        var mockCoordinate: CLLocationCoordinate2D!
        
        override var location: CLLocation? {
            return CLLocation(latitude: self.mockCoordinate.latitude, longitude: self.mockCoordinate.longitude)
        }
        
    }
}
