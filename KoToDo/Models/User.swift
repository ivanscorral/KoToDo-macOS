//
//  User.swift
//  KoToDo
//
//  Created by Ivan Sanchez on 4/11/23.
//

import Foundation
import SwiftData

@Model

final class User {
    var id: UInt32?
    var name: String
    var email: String
    var password: String
    
    init(id: UInt32? = nil, name: String, email: String, password: String) {
        self.id = id
        self.name = name
        self.email = email
        self.password = password
    }
}
