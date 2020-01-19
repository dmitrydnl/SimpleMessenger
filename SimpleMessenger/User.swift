//
//  User.swift
//  SimpleMessenger
//
//  Created by Dmitry Danilin on 19.01.2020.
//  Copyright © 2020 Dmitry Danilin. All rights reserved.
//

struct User {
    var uid: String
    var email: String?
    
    
    init(uid: String, email: String?) {
        self.uid = uid
        self.email = email
    }
}
