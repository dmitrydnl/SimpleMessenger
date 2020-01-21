//
//  ChatView.swift
//  SimpleMessenger
//
//  Created by Dmitry Danilin on 21.01.2020.
//  Copyright © 2020 Dmitry Danilin. All rights reserved.
//

import SwiftUI

struct ChatView: View {
    @State var typedMessage = ""
    @ObservedObject var messages = MessagesObserver()
    
    var body: some View {
        NavigationView {
            VStack {
                List(messages.messages) { i in
                    Text(i.message)
                }
                .navigationBarTitle("Chat")
                
                HStack {
                    TextField("Type message", text: $typedMessage)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    Button(action: {
                        self.messages.addMessage(message: self.typedMessage, email: "test")
                        self.typedMessage = ""
                    }) {
                        Text("Send")
                    }
                }
                .padding()
            }
        }
    }
}

struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        ChatView()
    }
}
