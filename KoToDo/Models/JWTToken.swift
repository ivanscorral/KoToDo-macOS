//
//  JWTToken.swift
//  KoToDo
//
//  Created by Ivan Sanchez on 4/11/23.
//

import Foundation
import JWTDecode

class JWTToken: Equatable {
    static func == (lhs: JWTToken, rhs: JWTToken) -> Bool {
        lhs.token == rhs.token
    }
    
    var id: String? = nil
    var token: String
    var userId: Int? = nil
    var username: String? = nil
    
    init(token: String) {
        self.token = token
        decodeJWT()
    }
    
    private func decodeJWT() {
        do {
            let jwt = try decode(jwt: token)
            
            self.id = jwt.claim(name: "jti").string
            self.userId = jwt.claim(name: "userId").integer
            self.username = jwt.claim(name: "username").string
            
        } catch {
            print(error.localizedDescription)
        }
    }
    
}
