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
    case logout
}

let myAccountReducer = Reducer<MyAccountState, MyAccountAction, Void> { state, action, _ in
    switch action {
    case .logout:
        return .none
    case .remove(let id):
        return Effect.just(.remove(id))
    }
}
