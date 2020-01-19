//
//  ContentView.swift
//  SimpleMessenger
//
//  Created by Dmitry Danilin on 19.01.2020.
//  Copyright © 2020 Dmitry Danilin. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var session: UserSession
    
    func getUser() {
        session.listen()
    }
    
    var body: some View {
        Group {
            if (session.session != nil) {
                Text("Welcome back user!")
                Button(action: session.signOut) {
                    Text("Sign out")
                }
            } else {
                AuthView()
            }
        }
        .onAppear(perform: getUser)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(UserSession())
    }
}
