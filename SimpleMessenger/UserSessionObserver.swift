//
//  UserSession.swift
//  SimpleMessenger
//
//  Created by Dmitry Danilin on 19.01.2020.
//  Copyright © 2020 Dmitry Danilin. All rights reserved.
//

import SwiftUI
import Combine
import Firebase

class UserSessionObserver: ObservableObject {
    var didChange = PassthroughSubject<UserSessionObserver, Never>()
    @Published var session: User? {didSet { self.didChange.send(self) }}
    var handle: AuthStateDidChangeListenerHandle?
    
    func isMyEmail(email: String) -> Bool {
        return (session != nil && session?.email != nil) ? email == session?.email : false
    }
    
    func getEmail() -> String {
        if session != nil {
            return session?.email ?? "no_email"
        }
        
        return "no_email"
    }
    
    func listen() {
        handle = Auth.auth().addStateDidChangeListener({ (auth, user) in
            if let user = user {
                self.session = User(uid: user.uid, email: user.email)
            } else {
                self.session = nil
            }
        })
    }
    
    func signUp(email: String, password: String, handler: @escaping AuthDataResultCallback) {
        Auth.auth().createUser(withEmail: email, password: password, completion: handler)
    }
    
    func signIn(email: String, password: String, handler: @escaping AuthDataResultCallback) {
        Auth.auth().signIn(withEmail: email, password: password, completion: handler)
    }
    
    func signOut() {
        do {
            try Auth.auth().signOut()
            self.session = nil
        } catch {
            print("Sign out error")
        }
    }
    
    func unbind() {
        if let handle = handle {
            Auth.auth().removeStateDidChangeListener(handle)
        }
    }
    
    deinit {
        unbind()
    }
}
