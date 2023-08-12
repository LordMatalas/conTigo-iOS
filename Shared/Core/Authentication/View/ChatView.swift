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
    
    var body: some View {
        VStack{
            HStack{
                Text("conTigo")
                    .font(.largeTitle)
                    .bold()
                
                Image(systemName: "bubble.left.fill")
                    .font(.system(size: 26))
                    .foregroundColor(Color.blue)
            }
            ScrollView {
                ForEach(viewModel.messages.filter({$0.role != .system}),
                        id: \.id) {message in
                    messageView(message: message)
                    /*HStack {
                        Spacer()
                        Text(message)
                            .padding()
                            .foregroundColor(.white)
                            .backgroundStyle(.blue.opacity(0.8))
                            .cornerRadius(25)
                            .padding(.horizontal, 16)
                            .padding(.bottom, 10)
                    }*/
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
    }
        }
        
            
    
    func messageView(message: Message) -> some View{
        HStack {
            if message.role == .user {Spacer()}
            Text(message.content)
            if message.role == .assistant { Spacer()}
        }
    }
    
    
    struct ChatView_Previews: PreviewProvider {
        static var previews: some View {
            ChatView()
        }
    }
}
