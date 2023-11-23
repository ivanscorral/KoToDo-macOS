//
//  LoginHandler.swift
//  KoToDo
//
//  Created by Ivan Sanchez on 6/11/23.
//

import Foundation

struct LoginRequest: Codable {
    var name: String
    var password: String
    
    init(usernameOrEmail: String, password: String) {
        self.name = usernameOrEmail
        self.password = password
    }
}

struct JWTResponse: Codable {
    var jwt: String
    var expirationTime: String
}

class LoginHandler {
    
    
    
    init() {}
    
    public func login(_ params: LoginRequest, completion: @escaping (Result<ApiResponse<JWTResponse>, ApiError>) -> Void) {
        
        
        NetworkService.shared.request(endpoint: .signin, headers: nil, body: params) { (result: Result<ApiResponse<JWTResponse>, ApiError>) in
            switch result {
            case .success(let apiResponse):
                completion(.success(apiResponse))
            case .failure(let error):
                print(error)
                completion(.failure(error))
            }
            
        }
        
    }
}
