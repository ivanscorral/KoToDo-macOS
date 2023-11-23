//
//  CodableUser.swift
//  KoToDo
//
//  Created by Ivan Sanchez on 5/11/23.
//

import Foundation

struct NewUserPayload: Codable {
    var name: String
    var email: String
    var password: String
    
    init(name: String, email: String, password: String) {
        self.name = name
        self.email = email
        self.password = password
    }
}


// CodableUser to represent the user data from server response
struct CodableUser: Codable {
    var id: UInt32?
    var name: String
    var email: String
    var passwordHash: String?
    var createdAt: String?
    var updatedAt: String?

    enum CodingKeys: String, CodingKey {
        case id, name, email, passwordHash, createdAt, updatedAt
    }
}
