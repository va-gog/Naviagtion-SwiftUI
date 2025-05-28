//
//  AppLaunchReducer.swift
//  TCA
//
//  Created by Gohar Vardanyan on 11.03.25.
//

import Foundation
import Combine
import CasePaths

struct AppLaunchState: Equatable {
    var locPermitionState: LocPermitionState? = nil
    var authenticationState: AuthenticationState? = nil
    var mainScreenState: MainScreenState? = nil
    var forecastState: ForecastState? = nil
    var settingsState: SettingsState? = nil
}

enum AppLaunchAction: Equatable {
    case onAppear
    case locPermitionAction(LocPermitionAction)
    case authenticationAction(AuthenticationAction)
    case mainScreenAction(MainScreenAction)
    case forecastAction(ForecastAction)
    case settingsAction(SettingsViewAction)
    case forecastAdded(String)
}

//let appLaunchReducer = Reducer<AppLaunchState, AppLaunchAction, Void> { state, action, _ in
//    switch action {
//    case .onAppear:
//        state.locPermitionState = LocPermitionState()
//        return .none
//    case .locPermitionAction(.locationAccessPermited):
//        state.locPermitionState = nil
//        state.authenticationState = AuthenticationState()
//        return .none
//    case .authenticationAction(.loggedIn):
//        state.authenticationState = nil
//        state.mainScreenState = MainScreenState()
//        return .none
//    case .mainScreenAction(.showNavigationScreen1):
//        state.forecastState = ForecastState()
//        return .none
//    case .mainScreenAction(.showNavigationScreen2):
//        state.settingsState = SettingsState()
//        return .none
//    case .forecastAction(.logout):
//        state.forecastState = nil
//        state.mainScreenState = nil
//        state.authenticationState = AuthenticationState()
//        return .none
//    case .forecastAction(.add(let item)):
//        return Effect.just(.forecastAdded(item))
//    case .forecastAdded(let value):
//        state.forecastState = nil
//        state.mainScreenState?.items.append(value)
//        return .none
//    case .settingsAction(.close):
//        state.settingsState = nil
//        return .none
//    case .settingsAction(.myAccountAction(.logout)):
//        return Effect.just(.settingsAction(.close))
//    case .settingsAction(let settingsAction):
//        if var settingsState = state.settingsState {
//            let action = settingsReducer.reduce(&settingsState, settingsAction, ()).map( { AppLaunchAction.settingsAction($0) } )
//            state.settingsState = settingsState
//            return action
//        }
//
//        return .none
//    default:
//        return .none
//    }
//}

let appLaunchReducer = Reducer<AppLaunchState, AppLaunchAction, Void>.combine(
    // Child reducers
    settingsReducer.pullback(
        state: \.settingsState,
        action: /AppLaunchAction.settingsAction,
        environment: { _ in () }
    ),
    mainScreenReducer.pullback(
        state: \.mainScreenState,
        action: /AppLaunchAction.mainScreenAction,
        environment: { _ in () }
    ),
    forecastReducer.pullback(
        state: \.forecastState,
        action: /AppLaunchAction.forecastAction,
        environment: { _ in () }
    ),
    locPermitionReducer.pullback(
        state: \.locPermitionState,
        action: /AppLaunchAction.locPermitionAction,
        environment: { _ in () }
    ),
    authenticationReducer.pullback(
        state: \.authenticationState,
        action: /AppLaunchAction.authenticationAction,
        environment: { _ in () }
    ),
    // Parent-level reducer
    Reducer { state, action, _ in
        switch action {
        case .onAppear:
            state.locPermitionState = LocPermitionState()
            return .none
        case .locPermitionAction(.locationAccessPermited):
            state.locPermitionState = nil
            state.authenticationState = AuthenticationState()
            return .none
        case .authenticationAction(.loggedIn):
            state.authenticationState = nil
            state.mainScreenState = MainScreenState()
            return .none
        case .mainScreenAction(.showNavigationScreen1):
            state.forecastState = ForecastState()
            return .none
        case .mainScreenAction(.showNavigationScreen2):
            state.settingsState = SettingsState()
            return .none
        case .forecastAction(.logout):
            state.forecastState = nil
            state.mainScreenState = nil
            state.authenticationState = AuthenticationState()
            return .none
        case .forecastAction(.add(let item)):
            return Effect.just(.forecastAdded(item))
        case .forecastAdded(let value):
            state.forecastState = nil
            state.mainScreenState?.items.append(value)
            return .none
        case .settingsAction(.close):
            state.settingsState = nil
            return .none
        case .settingsAction(.myAccountAction(.logout)):
            return Effect.just(.settingsAction(.close))
        case .settingsAction(.myAccountAction(.remove(let id))):
             state.mainScreenState?.items.removeLast()
            state.mainScreenState = state.mainScreenState
            return .none
        default:
            return .none
        }
    }
)
