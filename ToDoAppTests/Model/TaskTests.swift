//
//  TaskTests.swift
//  ToDoAppTests
//
//  Created by Олеся Егорова on 04.11.2021.
//

import XCTest
@testable import ToDoApp


class TaskTests: XCTestCase {

//проверяем что можем инициализировать таск с помощью заголовка
    func testInitTaskWithTitle(){
        let task = Task(title: "Foo") //Foo Bar Baz
        //проверяем что объект существует
        XCTAssertNotNil(task)
    }
    
    func testInitTaskWithTitleAndDescription(){
        let task = Task(title: "Foo", description: "Bar")
        XCTAssertNotNil(task)
    }
    //проверяем что установился заголовок/описание
    func testWhenGivenTitleSetsTitle(){
        let task = Task(title: "Foo")
        XCTAssertEqual(task.title, "Foo")
    }
    func testWhenGivenDescriptionSetsDescription(){
        let task = Task(title: "Foo", description: "Bar")
        XCTAssertEqual(task.description, "Bar")
    }
    
    func testTaskInitsWithDate(){
        let task = Task(title: "Foo")
        XCTAssertNotNil(task.date)
    }
    
    func testWhenGivenLocationSetsLocation(){
        let location = Location(name: "Foo")
        let task = Task(title: "Bar", description: "Baz", location: location)
        XCTAssertEqual(location, task.location)
        
    }
}
