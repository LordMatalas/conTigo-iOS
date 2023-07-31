//
//  ProfileView.swift
//  ChatBot Demo
//
//  Created by Daniel Alarcón S on 23/07/23.
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    // @EnvironmentObject var chatModel: ChatView
    var body: some View {
        if let user = viewModel.currentUser {
            List {
                Section {
                    HStack {
                        Text(user.initials)
                        .font(.title)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .frame(width: 72, height: 72)
                        .background(Color(.systemGray3))
                    .clipShape(Circle())
                    
                        VStack{
                            Text(user.fullname)
                                .font(.subheadline)
                                .fontWeight(.semibold)
                                .padding(.top, 4)
                            
                            Text(user.email)
                                .font(.footnote)
                                .foregroundColor(.gray)
                                
                            
                        }
                    }
                    
                }
                
                Section("General") {
                    HStack(spacing: 10){
                        Image(systemName: "gear")
                            .font(.title)
                        VStack(alignment: .leading, spacing: 2) {
                            Text("Version")
                                .font(.headline)
                                // .tintColor: Color(.systemGray) no se puede por la versión de Xcode
                            Text("1.0.0")
                                .font(.caption)
                        }
                    }
                    
                }
                
                Section ("Account") {
                    Button {
                        Task{
                            viewModel.signOut()
                        }
                        
                    } label: {
                        HStack(spacing: 10){
                            Image(systemName: "arrow.left.circle.fill")
                                .font(.title)
                                .foregroundColor(.red)
                            VStack(alignment: .leading, spacing: 2) {
                                Text("Sign out")
                                    .font(.headline)
                                    .foregroundColor(.black)
                            
                            }
                        }
                    }
                    Button {
                        print("Eliminar cuenta")
                        
                    } label: {
                        HStack(spacing: 10){
                            Image(systemName: "xmark.circle.fill")
                                .font(.title)
                                .foregroundColor(.red)
                            VStack(alignment: .leading, spacing: 2) {
                                Text("Delete account")
                                    .font(.headline)
                                    .foregroundColor(.black)
                            
                            }
                        }
                    }
                    Button {
                        print("Chat")
                    } label: {
                        HStack(spacing: 20){
                            Image(systemName: "globe")
                                .font(.title)
                                .foregroundColor(.green)
                            VStack(alignment: .leading, spacing: 2){
                            Text("Chat")
                                .font(.headline)
                                .foregroundColor(.black)
                            }
                        }
                        
                    }
                }
            }
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
