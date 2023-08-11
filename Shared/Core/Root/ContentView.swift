//
//  ContentView.swift
//  Shared
//
//  Created by Daniel Alarcón S on 13/07/23.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    var body: some View {
        Group {
            if viewModel.userSession != nil {
                ChatView()
                   
            } else {
                LoginView()
                    
            }
        }
    }
}

    
struct ContentView_Previews: PreviewProvider {
    static var previews: some View{
        ContentView()
            .environmentObject(AuthViewModel())
    }
}
