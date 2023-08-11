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
            ScrollView {
                ForEach(viewModel.messages.filter({$0.role != .system}),
                        id: \.id) {message in
                    messageView(message: message)
                }
            }
            HStack {
                TextField("Enter a message...", text: $viewModel.currentInput)
                Button {
                    viewModel.sendMessage()
                } label: {
                    Text("Send")
                }
            }
        }
        .padding()
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
