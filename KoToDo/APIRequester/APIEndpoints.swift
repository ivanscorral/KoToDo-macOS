//
//  APIEndpoints.swift
//  KoToDo
//
//  Created by Ivan Sanchez on 4/11/23.
//

import Foundation


enum APIEndpoint {
    case newUser
    case updateUser(User)
    
    var info: (path: String, method: HTTPMethod) {
          switch self {
          case .newUser:
              return ("/users", .post)
          case .updateUser(let userId):
              return ("/users/\(userId)", .put)
          }
  }
}
