//
//  AuthenticView.swift
//  TCA
//
//  Created by Gohar Vardanyan on 11.03.25.
//

import SwiftUI

struct AuthenticView: View {
    @ObservedObject var reducer: AuthenticationViewReducer
    
    var body: some View {
        VStack {
            Text("Authentication")
                .padding()
            Button(action: {
                reducer.send(AuthenticationViewReducer.AuthViewReducerAction.loggedIn)
            }) {
                Text("LogIn")
                    .foregroundColor(.blue)
                    .padding()
                    .background(Color(.systemGray5))
                    .cornerRadius(10)
            }
        }
    }
}
