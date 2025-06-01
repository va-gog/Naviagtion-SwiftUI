//
//  MyAccountViewReducer.swift
//  TCA
//
//  Created by Gohar Vardanyan on 17.03.25.
//

import Foundation

struct MyAccountState: State {
    var id: UUID = UUID()
}

enum MyAccountAction: Equatable {
    case remove(String)
    case didRequestLogout // <-- Add this
}

let myAccountReducer = Reducer<MyAccountState, MyAccountAction, Void> { state, action, _ in
    switch action {
    case .remove(let id):
        return Effect.just(.remove(id))
    case .didRequestLogout:
            return .none
    }
}
