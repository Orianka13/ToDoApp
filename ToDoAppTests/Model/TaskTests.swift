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
    
    func testCanBeCreatedFromPlistDictionary() {
        let location = Location(name: "Baz")
        let date = Date(timeIntervalSince1970: 10)
        let task = Task(title: "Foo", description: "Bar", date: date, location: location)
        let locationDictionary: [String : Any] = ["name": "Baz"]
        
        let dictionary: [String : Any] = ["title": "Foo",
                                          "description": "Bar",
                                          "date": date,
                                          "location": locationDictionary]
        let createdTask = Task(dict: dictionary)
        
        XCTAssertEqual(task, createdTask)
    }
    
    //проверим что Task может быть сериализован в словарь
    func testCanBeSerializedIntoDictionary() {
        let location = Location(name: "Baz")
        let date = Date(timeIntervalSince1970: 10)
        let task = Task(title: "Foo", description: "Bar", date: date, location: location)
        
        let generatedTask = Task(dict: task.dict)
        
        XCTAssertEqual(task, generatedTask)
    }
}
