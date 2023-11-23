//
//  NavigationItem.swift
//  KoToDo
//
//  Created by Ivan Sanchez on 8/11/23.
//

import Foundation

enum NavigationItem: String, CaseIterable, Identifiable {
    case home = "Home"
    case settings = "Settings"
    case login = "Login"
    case signup = "Sign Up"
    case add = "Add"
    case list = "List"
    
    var id: String { return self.rawValue }
}

class NavigationViewModel: ObservableObject {
    @Published var loggedIn = false
    @Published var navigationItem: NavigationItem = .home
}
