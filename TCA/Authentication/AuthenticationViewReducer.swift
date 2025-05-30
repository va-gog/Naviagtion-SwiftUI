//
//  AuthenticationViewReducer.swift
//  TCA
//
//  Created by Gohar Vardanyan on 11.03.25.
//

import Foundation

struct AuthenticationState: State {
    var id: UUID = UUID()
    var isLoggedIn: Bool = false
}

enum AuthenticationAction: Equatable {
    case loggedIn
}

let authenticationReducer = Reducer<AuthenticationState, AuthenticationAction, Void> { state, action, _ in
    switch action {
    case .loggedIn:
        state.isLoggedIn = true
        return .none
    }
}
