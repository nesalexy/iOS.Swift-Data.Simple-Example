//
//  SwiftDataExampleApp.swift
//  SwiftDataExample
//
//  Created by Alexy Nesterchuk on 08.07.2024.
//

import SwiftUI
import SwiftData

@main
struct SwiftDataExampleApp: App {
    
    // example of custom settings
    let container: ModelContainer = {
        let schema = Schema([Expense.self])
        let container = try! ModelContainer(for: schema, configurations: [])
        return container
    }()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        //.modelContainer(for: [Expense.self])
        .modelContainer(container)
    }
}
