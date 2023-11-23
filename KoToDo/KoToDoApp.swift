//
//  KoToDoApp.swift
//  KoToDo
//
//  Created by Ivan Sanchez on 4/11/23.
//

import SwiftUI
import SwiftData

@main
struct KoToDoApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Item.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(UserAuthenticationManager())
        }
        .modelContainer(sharedModelContainer)
    }
    
}

