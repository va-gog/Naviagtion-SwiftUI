//
//  SettingsViewReducer.swift
//  TCA
//
//  Created by Gohar Vardanyan on 13.03.25.
//

import Combine
import Foundation
import CasePaths

struct SettingsState: State {
    var id: UUID = UUID()
    var navigationState = SettingsNavigationState()
    var isLoading: Bool = false
}

struct SettingsNavigationState: NavigationState, Hashable {
    var navigationPath: [SettingsScreenState] = []
    var screenCoverState: SettingsScreenState?
}

enum SettingsScreenState: State, Hashable {
    case myAccount(MyAccountState)
    // Add more cases if needed
    var id: UUID {
        switch self {
        case .myAccount(let state): return state.id
        }
    }
}

enum SettingsViewAction: Equatable {
    case navigation(NavigationAction<SettingsScreenState>)
    case myAccount
    case myAccountAction(MyAccountAction)
    case close
    case myAccountDidRemove(String)
    case myAccountDidRequestLogout // <-- Add this
    case logoutCompleted // <-- Add this for async completion
    case setLoading(Bool) // <-- For loading indicator
}

let settingsNavReducer: Reducer<SettingsNavigationState, NavigationAction<SettingsScreenState>, Void> = navigationReducer()
let myAccountForEach = forEachEnumCase(
    statePath: \SettingsNavigationState.navigationPath,
    casePath: /SettingsScreenState.myAccount,
    actionPath: /SettingsViewAction.myAccountAction,
    reducer: myAccountReducer
)

let settingsReducer: Reducer<SettingsState, SettingsViewAction, Void> = Reducer.combine(
    settingsNavReducer.pullback(
        state: \.navigationState,
        action: /SettingsViewAction.navigation,
        environment: { _ in () }
    ),
    myAccountForEach.pullback(
        state: \.navigationState,
        action: .self,
        environment: { _ in () }
    ),
    Reducer { state, action, _ in
        switch action {
        case .myAccount:
            return Effect.just(.navigation(.push(.myAccount(MyAccountState()))))
        case .close:
            return .none
        case .myAccountDidRemove:
            return .none
        case .myAccountAction(.didRequestLogout):
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
            return Effect.just(.myAccountDidRequestLogout)
        case .myAccountAction:
            return .none
        default:
            return .none
        }
    }
)
