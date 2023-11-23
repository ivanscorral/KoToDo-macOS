//
//  Sidebar.swift
//  KoToDo
//
//  Created by Ivan Sanchez on 8/11/23.
//

import Foundation
import SwiftUI

struct Sidebar: View {
    @EnvironmentObject var authManager: UserAuthenticationManager
    @Binding var selectedNavigationItem: NavigationItem
    @Binding var loggedIn: Bool
    
    var body: some View {
        List(selection: $selectedNavigationItem) {
            if authManager.isLoggedIn {
                NavigationLink(value: NavigationItem.home){
                    Label("Home", systemImage: "house")
                }
                .tag(NavigationItem.home)
                
                NavigationLink(value: NavigationItem.add){
                    Label("Add", systemImage: "plus")
                }
                .tag(NavigationItem.add)
                
                NavigationLink(value: NavigationItem.list){
                    Label("List", systemImage: "list.bullet")
                }
                .tag(NavigationItem.list)
                
                NavigationLink(value: NavigationItem.settings){
                    Label("Settings", systemImage: "gear")
                }
                .tag(NavigationItem.settings)
            } else {
                NavigationLink(value: NavigationItem.login){
                    Label("Login", systemImage: "person")
                }
                .tag(NavigationItem.login)
                
                NavigationLink(value: NavigationItem.signup){
                    Label("Sign Up", systemImage: "person.badge.plus")
                }
                .tag(NavigationItem.signup)
            }
        }
        .listStyle(SidebarListStyle())
        .animation(.easeInOut, value: selectedNavigationItem)
        .frame(minWidth: 150, idealWidth: 150, maxWidth: 200, maxHeight: .infinity)
        .navigationTitle("KoToDo")
    }
}
