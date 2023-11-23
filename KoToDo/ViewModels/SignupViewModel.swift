//
//  SignupViewModel.swift
//  KoToDo
//
//  Created by Ivan Sanchez on 9/11/23.
//

import Foundation
import Combine


class SignupViewModel: ObservableObject {
    @Published var errorMessage: String = ""
    @Published var signedUpUser: CodableUser? = nil
    
    /// SignupHandler instance used to make signup requests to the API.
    
    private var signupHandler = SignupHandler()
    
    /// This function makes use of the `SignupHandler` to make a signup request to the API and updates the `errorMessage` and `loggedUser` properties accordingly.
    ///
    /// The `SignupHandler` makes use of the `NetworkService` to make the request to the API.
    ///
    /// - Parameters:
    ///   - username: Name of the user
    ///   - email: Email of the user
    ///   - password: Password of the user, must be at least 6 characters long.
    ///
    /// - Completion:
    /// On completion, the `errorMessage` and `loggedUser` properties are updated accordingly.
    /// These properties are `@Published`, so the view is in charge of updating its content.

    func signup(username: String, email: String, password: String) {
        let params = SignupRequest(name: username, email: email, password: password)
        signupHandler.signup(params: params) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let signupResponse):
                    self?.signedUpUser = signupResponse.data
                    print("\(signupResponse.message) - \(signupResponse.data.name)")
                case .failure(let error):
                    print(error.localizedDescription)
                    self?.errorMessage = error.localizedDescription
                }
            }
        }
    }
}
