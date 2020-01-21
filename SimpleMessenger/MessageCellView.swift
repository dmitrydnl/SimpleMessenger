//
//  MessageCellView.swift
//  SimpleMessenger
//
//  Created by Dmitry Danilin on 21.01.2020.
//  Copyright © 2020 Dmitry Danilin. All rights reserved.
//

import SwiftUI

struct MessageCellView: View {
    var message: Message
    var isMyMessage : Bool
    
    var body: some View {
        HStack {
            if isMyMessage {
                Spacer()
                
                Text(message.message)
                    .padding()
                    .background(Color("Background_1"))
                    .clipShape(MessageCellTail(isMyMessage: isMyMessage))
                    .foregroundColor(.white)
            } else {
                Text(message.message)
                    .padding()
                    .background(Color("Background_2"))
                    .clipShape(MessageCellTail(isMyMessage: isMyMessage))
                    .foregroundColor(.white)
                
                Spacer()
            }
        }
        .padding(isMyMessage ? .leading : .trailing, 55)
        .padding(.vertical,10)
    }
}

struct MessageCellTail: Shape {
    var isMyMessage : Bool
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect,
                                byRoundingCorners: [.topLeft,.topRight,isMyMessage ? .bottomLeft : .bottomRight],
                                cornerRadii: CGSize(width: 25, height: 25))
        return Path(path.cgPath)
    }
}

struct MessageCellView_Previews: PreviewProvider {
    static var previews: some View {
        MessageCellView(message: Message(id: "12345", email: "test@mail.com", message: "Hello"), isMyMessage: true)
    }
}
