//
//  SettingsViewReducer.swift
//  TCA
//
//  Created by Gohar Vardanyan on 13.03.25.
//

import Combine
import Foundation
import CasePaths

struct SettingsNavigationState: NavigationState, Hashable {
    var navigationPath: [SettingsScreenState] = []
    var screenCoverState: SettingsScreenState?
}

enum SettingsScreenState: State, Hashable {
    case myAccount(MyAccountState)
    
    var id: UUID {
        switch self {
        case .myAccount(let state): return state.id
        }
    }
}

struct SettingsState: State {
    var id: UUID = UUID()
    var navigationState = SettingsNavigationState()
    var isLoading = false
}

enum SettingsViewAction: Equatable {
    case navigation(NavigationAction<SettingsScreenState>)
    case myAccount
    case close
    case myAccountAction(MyAccountAction)
    case myAccountDidRequestRemove(Int)
    case myAccountDidRequestLogout
    case logoutCompleted
    case setLoading(Bool)
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
        case .myAccountAction(.didRequestRemove(let id)):
            return .concatenate(
                Effect.just(.navigation(.pop)),
                Effect.just(.myAccountDidRequestRemove(id))
            )
        case .myAccountAction(.logoutCompleted):
            return .concatenate(
                Effect.just(.navigation(.pop)),
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
        default:
            return .none
        }
    }
)
