//
//  Todo.swift
//  KoToDo
//
//  Created by Ivan Sanchez on 4/11/23.
//

import Foundation
import SwiftData

@Model

final class Todo {
    var id: UInt32?
    var title: String
    var todoDescription: String?
    var completed: Bool
    var createdAt: Date
    var updatedAt: Date
    
    init(id: UInt32? = nil, title: String, description: String? = nil, completed: Bool = false, createdAt: Date = Date(), updatedAt: Date = Date()) {
        self.id = id
        self.title = title
        self.todoDescription = description
        self.completed = completed
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }
}
