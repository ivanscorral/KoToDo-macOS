//
//  UserAuthManager.swift
//  KoToDo
//
//  Created by Ivan Sanchez on 10/11/23.
//

import Foundation
import Combine

class UserAuthenticationManager: ObservableObject {
    @Published var isLoggedIn = false
    
    
    func logIn(username: String, password: String) {
        isLoggedIn = true
    }
    
    func logOut() {
        isLoggedIn = false
    }
}
