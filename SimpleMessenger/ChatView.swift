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
    @EnvironmentObject var session: UserSessionObserver
    @ObservedObject var messages = MessagesObserver()
    
    var body: some View {
        NavigationView {
            VStack {
                List(messages.messages) { i in
                    MessageCellView(message: i, isMyMessage: self.session.isMyEmail(email: i.email))
                }
                .navigationBarTitle("Chat")
                .navigationBarItems(trailing:
                    Button(action: {
                        self.session.signOut()
                    }) {
                        Text("Log out")
                            .foregroundColor(.red)
                    }
                )
                
                HStack {
                    TextField("Message", text: $typedMessage)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    Button(action: {
                        self.messages.addMessage(message: self.typedMessage, email: self.session.getEmail())
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
        ChatView().environmentObject(UserSessionObserver())
    }
}
