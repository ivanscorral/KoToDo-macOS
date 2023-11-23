//
//  SignupHandler.swift
//  KoToDo
//
//  Created by Ivan Sanchez on 9/11/23.
//

import Foundation

struct SignupRequest: Codable {
    let name: String
    let email: String
    let password: String
}

struct SignupResponse: Codable {
    let data: CodableUser
}

class SignupHandler {
    
    init() {}
    
    public func signup(params: SignupRequest, completion: @escaping (Result<ApiResponse<CodableUser>, ApiError>) -> Void) {
        
        NetworkService.shared.request(endpoint: .signup, headers: nil, body: params) { (result: Result<ApiResponse<CodableUser>, ApiError>) in
            
            switch result {
            case .success(let apiResponse):
                completion(.success(apiResponse))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
