//
//  Endpoints.swift
//  KoToDo
//
//  Created by Ivan Sanchez on 9/11/23.
//

import Foundation

enum Endpoint {
    case signin
    case signup
    case other
    
    var method: String {
        switch self {
        case .signin, .signup:
            return "POST"
        default:
            return "GET"
        }
    }
    
    var path: String {
        switch self {
        case .signin:
            return "/users/login"
        case .signup:
            return "/users/new"
        default:
            return ""
        }
    }
}
