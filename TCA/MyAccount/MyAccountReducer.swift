//
//  MyAccountReducer.swift
//  TCA
//
//  Created by Gohar Vardanyan on 17.03.25.
//

import Foundation
import Combine

struct MyAccountState: State {
    var id: UUID = UUID()
    var isLoading: Bool = false
}

enum MyAccountAction: Equatable {
    case didRequestRemove(Int)
    case didRequestLogout
    case logoutCompleted
    case setLoading(Bool)
}

let myAccountReducer = Reducer<MyAccountState, MyAccountAction, Void> { state, action, _ in
    switch action {
    case .didRequestLogout:
        return .concatenate(
         Effect.just(.setLoading(true)),
        Effect(
            Deferred {
                Future { promise in
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        promise(.success(.logoutCompleted))
                    }
                }
            }
                .eraseToAnyPublisher()
        ))
    case .setLoading(let isLoading):
        state.isLoading = isLoading
        return .none
    case .logoutCompleted:
        return .none
    default:
        return .none
    }
}
