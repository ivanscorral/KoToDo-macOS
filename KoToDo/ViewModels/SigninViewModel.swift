//
//  SigninViewHandler.swift
//  KoToDo
//
//  Created by Ivan Sanchez on 10/11/23.
//

import Foundation
import Combine

class SigninViewModel: ObservableObject {
    
    @Published var jwt: JWTToken? = nil
    @Published var errorMessage: String = ""
    
    
    private let signinHandler = LoginHandler()
    
    init() { }
    
    func signin(name: String, password: String) {
        
        let params = LoginRequest(usernameOrEmail: name, password: password)
        
        signinHandler.login(params) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    self?.jwt = JWTToken(token: response.data.jwt)
                    print("JWT: \(response.data.jwt)")
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                    print(error)
                }
            }
        }
    }
}
