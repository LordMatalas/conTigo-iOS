//
//  ChatView.swift
//  ChatBot Demo
//
//  Created by Daniel Alarcón S on 29/07/23.
//

import SwiftUI

struct ChatView: View {
    @State private var messageText = ""
    @State var messages: [String] = ["Welcome to conTigo demo"]
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var viewModel: AuthViewModel

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
                    
        // Linea 19 a 27 se encargan del ícono en la parte superior de la pantalla
                    
                ScrollView {
                    ForEach(messages, id: \.self) {message in
                        if message.contains("[USER]"){
                            let newMessage = message.replacingOccurrences(of: "[USER]", with: "")
                                HStack {
                                    Spacer()
                                    Text(newMessage)
                                        .padding()
                                        .foregroundColor(.white)
                                        .background(.blue.opacity(0.8))
                                        .cornerRadius(25)
                                        .padding(.horizontal, 16)
                                        .padding(.bottom, 10)
                                }
                                
                            } else{
                                HStack {
                                    
                                    Text(message)
                                        
                                        .padding()
                                        .background(.gray.opacity(0.15))
                                        .cornerRadius(25)
                                        .padding(.horizontal, 16)
                                        
                                        .padding(.bottom, 10)
                                    Spacer()
                                }
                            }
                        }.rotationEffect(.degrees(180))
                    }.rotationEffect(.degrees(180))
                        .background(Color.gray.opacity(0.10))
                    
                    HStack {
                        TextField("Escribe algo...", text: $messageText)
                            .padding()
                            .background(Color.gray.opacity(0.1))
                            .cornerRadius(10)
                            .onSubmit {
                                sendMessage(message: messageText)
                            }
                        
                        Button {
                            sendMessage(message: messageText)
                        } label: {
                            Image(systemName: "paperplane.fill")
                        }
                        .font(.system(size: 26))
                        .padding(.horizontal, 10)
                    }
                    .padding()
                }
            }
            
            func sendMessage (message: String) {
                withAnimation {
                    messages.append("[USER]" + message)
                    self.messageText = ""
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    withAnimation {
                        messages.append(getBotResponse(message: message))
                    }
                }
            }
        }
        

struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        ChatView()
    }
}
