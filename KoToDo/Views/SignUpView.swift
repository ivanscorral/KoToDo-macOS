//
//  NewUserView.swift
//  KoToDo
//
//  Created by Ivan Sanchez on 4/11/23.
//

import SwiftUI
import Combine

struct SignUpView: View {
    
    @StateObject private var viewModel = SignupViewModel()
    
    @State var email: String = ""
    @State var password: String = ""
    @State var errorMessage: String = ""
    @State var username: String = ""
    @State var confirmPassword: String = ""
    @State var showPasswordConfirmation: Bool = false
    
    var body: some View {
        ZStack {
            // TODO: Add background color and shape
            
            
            
            // View content
            VStack(spacing: 16) {
                Spacer()
                // Fields:
                // - Username, email, password. When password != "", another fields pops down with an additional password confirmation, animated.
                // - Sign up button
                Text("Sign Up")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding()
                
                if let loggedUser = viewModel.signedUpUser {
                    Text("Successfully signed up as \(loggedUser.name), please log in with your e-mail (\(loggedUser.email)).")
                        .font(.headline)
                        .foregroundColor(.green)
                        .padding()
                } else {
                    // Input Fields
                    inputField(placeholder: "Username", text: $username)
                    inputField(placeholder: "Email", text: $email)
                    inputField(placeholder: "Password", text: $password, isSecure: true)
                        .onReceive(Just(password)) { newValue in
                            withAnimation {
                                showPasswordConfirmation = !newValue.isEmpty
                            }
                        }

                    // Password confirmation field
                    if showPasswordConfirmation {
                        inputField(placeholder: "Confirm Password", text: $confirmPassword, isSecure: true)
                    }
                    
                    // Sign Up Button
                    Button(action: {
                        validateSignup()
                        // Mock error message
                    }) {
                        Text("Sign Up")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                    }
                    .padding()
                    
                    // Error Message
                    if !errorMessage.isEmpty {
                        Text(errorMessage)
                            .foregroundColor(.red)
                    }
                }
                
                
                Spacer()
                
            }
        }
    }
    
    private func validateSignup() {
        guard !username.isEmpty else {
            errorMessage = "Username is required"
            return
        }
        
        guard validateEmail(email) else {
            errorMessage = "Invalid email"
            return
        }
        
        guard !password.isEmpty, password.count >= 6 else {
            errorMessage = "Password must be at least 6 characters long"
            return
        }
        
        guard password == confirmPassword else {
            errorMessage = "Passwords do not match"
            return
        }
        
        // TODO: Implement sign up logic
        errorMessage = ""
        print("Proceeding with email: \(email) and password: \(password)")
        
        viewModel.signup(username: username, email: email, password: password)
        
        // Debug view model
        
    }
    
    private func validateEmail(_ email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }
    
    /// Creates an input field that can be either a secure field or a regular text field.
    ///
    /// This function returns a view that is either a `SecureField` or a `TextField` depending on the `isSecure` parameter.
    /// The input field is limited in character length and is padded horizontally.
    ///
    /// Example:
    ///
    /// ```swift
    /// inputField(placeholder: "Password", text: $password, isSecure: true)
    /// ```
    ///
    /// - Parameters:
    ///   - placeholder: A `String` that is displayed when the field is empty.
    ///   - text: A `Binding<String>` that binds the input text to a state variable.
    ///   - isSecure: A `Bool` that determines whether the field is a secure field. Defaults to `false`.
    ///
    /// - Returns: A view that is either a `SecureField` or a `TextField`.
    ///
    @ViewBuilder
    func inputField(placeholder: String, text: Binding<String>, isSecure: Bool = false) -> some View {
        if isSecure {
            SecureField(placeholder, text: text.max(64))
                .padding(.horizontal, 20)
                
        } else {
            TextField(placeholder, text: text.max(256))
                .padding(.horizontal, 20)
        }
    }
}

#Preview {
    SignUpView()
}
