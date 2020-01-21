//
//  Message.swift
//  SimpleMessenger
//
//  Created by Dmitry Danilin on 21.01.2020.
//  Copyright © 2020 Dmitry Danilin. All rights reserved.
//

struct Message: Identifiable {
    var id: String
    var email: String
    var message: String
    
    init(id: String, email: String, message: String) {
        self.id = id
        self.email = email
        self.message = message
    }
}
