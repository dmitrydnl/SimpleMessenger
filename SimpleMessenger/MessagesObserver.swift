//
//  MessagesObserver.swift
//  SimpleMessenger
//
//  Created by Dmitry Danilin on 21.01.2020.
//  Copyright © 2020 Dmitry Danilin. All rights reserved.
//

import Firebase

class MessagesObserver: ObservableObject {
    @Published var messages = [Message]()
    
    init() {
        let database = Firestore.firestore()
        database.collection("messages").addSnapshotListener { (snap, error) in
            if error != nil {
                print((error?.localizedDescription)!)
                return
            }
            
            for i in snap!.documentChanges {
                if i.type == .added {
                    let id = i.document.documentID
                    let email = i.document.get("email") as! String
                    let message = i.document.get("message") as! String
                    let date = i.document.get("date") as! Double
                    self.messages.append(Message(id: id, email: email, message: message, date: date))
                }
            }
            self.messages.sort {
                $0.date < $1.date
            }
        }
    }
    
    func sendMessage(message: String, email: String) {
        let database = Firestore.firestore()
        database.collection("messages").addDocument(data: ["message": message, "email": email, "date": Date().timeIntervalSince1970]) { (error) in
            if error != nil {
                print((error?.localizedDescription)!)
                return
            }
            
            print("success")
        }
    }
}
