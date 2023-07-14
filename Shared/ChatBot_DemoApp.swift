//
//  ChatBot_DemoApp.swift
//  Shared
//
//  Created by Daniel Alarcón S on 13/07/23.
//

import SwiftUI

@main
struct ChatBot_DemoApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
