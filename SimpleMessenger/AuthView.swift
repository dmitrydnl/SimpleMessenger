//
//  AuthView.swift
//  SimpleMessenger
//
//  Created by Dmitry Danilin on 19.01.2020.
//  Copyright © 2020 Dmitry Danilin. All rights reserved.
//

import SwiftUI

struct AuthView: View {
    var body: some View {
        NavigationView {
            SignInView()
        }
    }
}

struct AuthView_Previews: PreviewProvider {
    static var previews: some View {
        AuthView().environmentObject(UserSession())
    }
}
