//
//  DetailView.swift
//  KoToDo
//
//  Created by Ivan Sanchez on 8/11/23.
//

import Foundation
import SwiftUI

struct DetailView: View {

    var navigationItem: NavigationItem
    
    var body: some View {
        NavigationStack {
            switch navigationItem {
            case .home:
                HomeView()
            case .settings:
                HomeView()
            case .login:
                SignInView()
            case .signup:
                SignUpView()
            case .add:
                HomeView()
            case .list:
                HomeView()
            }
        }
    }
}
