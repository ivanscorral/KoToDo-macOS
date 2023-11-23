//
//  SignInView.swift
//  KoToDo
//
//  Created by Ivan Sanchez on 4/11/23.
//

import SwiftUI

struct SignInView: View {
    
    @StateObject var viewModel = SigninViewModel()
    
    @EnvironmentObject var userAuthManager: UserAuthenticationManager
    
    @State var usernameOrEmail: String = ""
    @State var password: String = ""
    @State var errorMessage: String = ""
    
    
    var body: some View {
        
        GeometryReader { geometry in
            HStack {
                Spacer()
                
                VStack(alignment: .center, spacing: 16) {
                    Spacer()
                    
                    if let loggedUsername = self.viewModel.jwt?.username {
                        welcomeView(loggedUsername)
                    } else {
                        loginFormView()
                    }
                    Spacer()
                }
                .frame(width: geometry.size.width * 0.8)
                .padding(.vertical, 20)
                Spacer()
            }
        }
    }
    
    @ViewBuilder
    private func welcomeView(_ username: String) -> some View {
        Text("Welcome \(username)")
            .font(.title)
            .fontWeight(.bold)
            .foregroundColor(.white)
            .padding(.bottom, 16)
    }
    
    @ViewBuilder
    private func loginFormView() -> some View {
        // Placeholder resource
        Image(systemName: "doc.badge.plus")
            .resizable()
            .scaledToFit()
            .frame(width: 100, height: 100)
        
        // Form group
        Group {
            inputField(placeholder: "Username/Email", text: $usernameOrEmail)
            inputField(placeholder: "Password", text: $password, isSecure: true)
            
            
            Button(action: {
                doSignIn()
            }) {
                Text("Sign In")
                    .font(.headline)
                    .foregroundStyle(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
            }
        }
        // Show animated error message, only if there is one, dissapears after 10 seconds
        
        if !errorMessage.isEmpty {
            Text(errorMessage)
                .font(.caption)
                .foregroundStyle(.red)
                .animation(.smooth)
                .transition(.opacity.animation(.easeInOut))
                .padding(.bottom, 20)
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 10) {
                        errorMessage = ""
                    }
                }
        }
        
    }
    
    private func doSignIn() {
        // Validate fields
        
        guard !usernameOrEmail.isEmpty else {
            errorMessage = "Username or email is required"
            return
        }
        
        guard !password.isEmpty else {
            errorMessage = "Password is required"
            return
        }
        
        // Sign in
        
        viewModel.signin(name: usernameOrEmail, password: password)
        
    }
    
    
    @ViewBuilder
    private func inputField(placeholder: String, text: Binding<String>, isSecure: Bool = false) -> some View {
        if isSecure {
            SecureField(placeholder, text: text.max(64))
                .foregroundColor(.gray)
        } else {
            TextField(placeholder, text: text.max(256))
                .foregroundColor(.gray)
        }
    }
    
    
}

#Preview {
    SignInView()
}
