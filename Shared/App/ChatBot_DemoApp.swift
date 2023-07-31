//
//  ChatBot_DemoApp.swift
//  Shared
//
//  Created by Daniel Alarcón S on 13/07/23.
//

import SwiftUI
import Firebase

@main
struct ChatBot_DemoApp: App {
    @StateObject var viewModel = AuthViewModel()
    
    init(){
        FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(viewModel)
        }
    }
}
