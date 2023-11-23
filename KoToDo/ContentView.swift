//
//  ContentView.swift
//  KoToDo
//
//  Created by Ivan Sanchez on 4/11/23.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @StateObject var viewModel = NavigationViewModel()
    
    var body: some View {
        NavigationSplitView {
            Sidebar(selectedNavigationItem: $viewModel.navigationItem, loggedIn: $viewModel.loggedIn)
        } detail: {
            DetailView(navigationItem: viewModel.navigationItem)
        }
    }
}

#Preview {
    ContentView()
}
