//
//  JWTToken.swift
//  KoToDo
//
//  Created by Ivan Sanchez on 4/11/23.
//

import Foundation
import SwiftData

@Model

final class JWTToken {
    var id: UInt32?
    var token: String
    var userId: UInt32
    
    init(id: UInt32? = nil, token: String, userId: UInt32) {
        self.id = id
        self.token = token
        self.userId = userId
    }
}
