//
//  AuthenticView.swift
//  TCA
//
//  Created by Gohar Vardanyan on 11.03.25.

import SwiftUI

struct AuthenticView: View {
    @ObservedObject var viewStore: ViewStore<AuthenticationState, AuthenticationAction>
    
    init(store: Store<AuthenticationState, AuthenticationAction>) {
        self.viewStore = ViewStore(store: store)
    }
    
    var body: some View {
        VStack {
            Text("Authentication")
                .padding()
            Button(action: {
                viewStore.send(.loggedIn)
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
