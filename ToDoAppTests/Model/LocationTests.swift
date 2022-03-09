//
//  LocationTests.swift
//  ToDoAppTests
//
//  Created by Олеся Егорова on 27.01.2022.
//

import XCTest
@testable import ToDoApp
import CoreLocation

class LocationTests: XCTestCase {

    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
    }
    //проверим установку имени в инициализаторе
    func testInitSetsName() {
        let location = Location(name: "Foo")
        XCTAssertEqual(location.name, "Foo")
    }
    
    //проверим долготу и широту
    func testInitSetsCoordinates(){
        let coordinate = CLLocationCoordinate2D(latitude: 1,
                                                longitude: 2)
        let location = Location(name: "Foo", coordinate: coordinate)
        XCTAssertEqual(location.coordinate?.latitude, coordinate.latitude)
        XCTAssertEqual(location.coordinate?.longitude, coordinate.longitude)
    }
}
