//
//  AppLaunchReducer.swift
//  TCA
//
//  Created by Gohar Vardanyan on 11.03.25.
//

import Foundation
import Combine

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

let appLaunchReducer = Reducer<AppLaunchState, AppLaunchAction, Void> { state, action, _ in
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
    case .settingsAction(.myAccountDidRemove(let id)):
        state.mainScreenState?.items.removeAll { $0 == id }
        return .none
    case .settingsAction(let settingsAction):
        // Forward the action to the child reducer if state exists
        if var settingsState = state.settingsState {
            let _ = settingsReducer.reduce(&settingsState, settingsAction, ())
            state.settingsState = settingsState
        }
        return .none
    default:
        return .none
    }
}
