//
//  Task.swift
//  ToDoApp
//
//  Created by Олеся Егорова on 04.11.2021.
//

import Foundation

struct Task {
    let title: String
    let description: String?
    let date: Date?
    let location: Location?
    
    init(title: String, description: String? = nil, date: Date? = nil, location: Location? = nil){
        self.title = title
        self.description = description
        self.date = date ?? Date()
        self.location = location
    }
}
//MARK: Equatable
extension Task: Equatable {
    static func == (lhs: Task, rhs: Task) -> Bool {
        if lhs.title == rhs.title,
           lhs.description == rhs.description,
           lhs.location == rhs.location {
            return true
        }
        return false
    }
}
