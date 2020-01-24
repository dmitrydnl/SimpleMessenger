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
    @State var heightValue: CGFloat = 0
    @EnvironmentObject var session: UserSessionObserver
    @ObservedObject var messages = MessagesObserver()
    
    init() {
        UITableView.appearance().separatorStyle = .none
    }
    
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
                .onTapGesture {
                    UIApplication.shared.endEditing()
                }
                
                HStack {
                    TextField("Message", text: $typedMessage)
                        .padding(8)
                        .background(RoundedRectangle(cornerRadius: 90)
                        .strokeBorder(Color("Background_1"), lineWidth: 1))
                    
                    Button(action: {
                        if !self.typedMessage.isEmpty {
                            self.messages.sendMessage(message: self.typedMessage, email: self.session.getEmail())
                            self.typedMessage = ""
                            UIApplication.shared.endEditing()
                        }
                    }) {
                        Image(systemName: "paperplane.fill")
                            .font(.system(size: 22))
                    }
                }
                .padding()
            }
            .offset(y: -self.heightValue)
            .animation(.spring())
            .onAppear {
                NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: .main) { (not) in
                    let value = not.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! CGRect
                    let height = value.height
                    self.heightValue = height
                }
                
                NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: .main) { (not) in
                    self.heightValue = 0
                }
            }
        }
    }
}

struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        ChatView().environmentObject(UserSessionObserver())
    }
}
