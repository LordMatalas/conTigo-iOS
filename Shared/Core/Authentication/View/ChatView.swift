//
//  ChatView.swift
//  ChatBot Demo
//
//  Created by Daniel Alarcón S on 29/07/23.
//

import SwiftUI

struct ChatView: View {
    //@State private var messageText = ""
    //@State var messages: [String] = ["Welcome to conTigo demo"]
    //@Environment(\.dismiss) var dismiss
    @EnvironmentObject var viewModelA: AuthViewModel
    @ObservedObject var viewModel = ChatViewModel()
    @State private var authChat = true
    @State private var showProfileView = false
 
    var body: some View {
        VStack{
            HStack{
                Text("conTigo")
                    .font(.largeTitle)
                    .bold()
                
                Image(systemName: "bubble.left.fill")
                    .font(.system(size: 26))
                    .foregroundColor(Color.blue)
                
                NavigationLink {
                    ProfileView()
                    // .navigationBarBackButtonHiden(true)
                } label: {
                    HStack(spacing: 3){
                        Text("Perfil")
                            .fontWeight(.bold)
                    }
                    .font(.system(size: 14))
                }
            }
            ScrollView {
                ForEach(viewModel.messages, id: \.id) { message in
                    messageView(message: message)
                }
            }
            HStack {
                TextField("Enter a message...", text: $viewModel.currentInput)
                    .padding()
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(10)
                Button {
                    viewModel.sendMessage()
                } label: {
                    Image(systemName: "paperplane.fill")
                }
                .font(.system(size: 26))
                .padding(.horizontal,10)
            }
        
        .padding()
        .alert("conTigo no reemplaza la ayuda de un profesional", isPresented: $authChat){
            Button("Continuar") { }
        } message: {
            Text("Siéntete libre de expresar tus ideas, conTigo intentará la manera más amigable de asesorarte.")
        }
            
        
    }
        }
        
            
    
    func messageView(message: Message) -> some View {
        HStack {
            Spacer()
            if message.role != .user {
                Text(message.content)
                    .padding()
                    .foregroundColor(.black)
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(25)
                    .padding(.horizontal, 16)
                    .padding(.bottom, 10)
                    .frame(maxWidth: .infinity, alignment: .leading)
                //Spacer()
            } else {
                Text(message.content)
                    .padding()
                    .foregroundColor(.white)
                    .background(Color.blue.opacity(0.8))
                    .cornerRadius(25)
                    .padding(.horizontal, 16)
                    .padding(.bottom, 10)
            }
        }
    }

    
    struct ChatView_Previews: PreviewProvider {
        static var previews: some View {
            ChatView()
        }
    }
}
