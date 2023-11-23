//
//  HomeView.swift
//  KoToDo
//
//  Created by Ivan Sanchez on 8/11/23.
//

import Foundation
import SwiftUI


struct HomeView: View {
    
    var body: some View {
        VStack {
            Spacer()
            
            Image(systemName: "note.text")
                .font(.system(size: 128))
                .foregroundColor(.gray)
            
            // Welcome header
            
            Text("Welcome to KoToDo")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.gray)
            
            // Introduction text
            
            Text("KoToDo is a simple to-do app that helps you keep track of your tasks.")
                .multilineTextAlignment(.center)
                .foregroundColor(.gray)
            Spacer()
        }
    }
}
