//
//  APIEndpoints.swift
//  KoToDo
//
//  Created by Ivan Sanchez on 4/11/23.
//

import Foundation

struct ApiConfig {
    static let baseURL = "http://localhost:3000"
}

enum APIEndpoint {
    case newUser
    case updateUser(User)
    case deleteUser(User)
    
    case insertTodo(Todo)
    case deleteTodo(Todo)
    case updateTodo(Todo)
    
    var info: (path: String, method: HTTPMethod) {
          switch self {
          case .newUser:
              return ("/users/new", .post)
          case .updateUser(let userId):
              return ("/users/\(userId)", .put)
          case .deleteUser(let userId):
              return ("/users/\(userId)", .delete)
            case .insertTodo:
                return ("/todos", .post)
            case .deleteTodo:
                return ("/todos", .delete)
            case .updateTodo:
                return ("/todos", .put)                
          }
  }
}
