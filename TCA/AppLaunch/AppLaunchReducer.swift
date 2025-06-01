//
//  AppLaunchReducer.swift
//  TCA
//
//  Created by Gohar Vardanyan on 11.03.25.
//

import Foundation
import Combine
import CasePaths

import CasePaths

enum AppLaunchAction: Equatable {
    case onAppear
    case navigation(NavigationAction<AppScreenState>)
    case locPermitionAction(LocPermitionAction)
    case authenticationAction(AuthenticationAction)
    case mainScreenAction(MainScreenAction)
    case forecastAction(ForecastAction)
    case settingsAction(SettingsViewAction)
    case myAccountAction(MyAccountAction)
    case didLogoutFromSettings // <-- Add this
}

let mainScreenForEach = forEachEnumCase(
    statePath: \AppNavigationState.navigationPath,
    casePath: /AppScreenState.main,
    actionPath: /AppLaunchAction.mainScreenAction,
    reducer: mainScreenReducer
)
let forecastForEach = forEachEnumCase(
    statePath: \AppNavigationState.navigationPath,
    casePath: /AppScreenState.forecast,
    actionPath: /AppLaunchAction.forecastAction,
    reducer: forecastReducer
)
let settingForScreenCover = forCaseInOptional(
    statePath: \AppNavigationState.screenCoverState,
    casePath: /AppScreenState.settings,
    actionPath: /AppLaunchAction.settingsAction,
    reducer: settingsReducer
)

let navReducer: Reducer<AppNavigationState, NavigationAction<AppScreenState>, Void> = navigationReducer()
let appLaunchReducer: Reducer<AppLaunchState, AppLaunchAction, Void> = Reducer.combine(
    navReducer.pullback(
        state: \.navigationState,
        action: /AppLaunchAction.navigation,
        environment: { _ in () }
    ),
    mainScreenForEach.pullback(
        state: \.navigationState,
        action: .self,
        environment: { _ in () }
    ),
    forecastForEach.pullback(
        state: \.navigationState,
        action: .self,
        environment: { _ in () }
    ),
    settingForScreenCover.pullback(
        state: \.navigationState,
        action: .self,
        environment: { _ in ()}
    ),
    
    Reducer<AppLaunchState, AppLaunchAction, Void> { state, action, _ in
        switch action {
        case .onAppear:
            return Effect.just(.navigation(.present(.locPermition(LocPermitionState()))))
        case .locPermitionAction(.locationAccessPermited):
            return Effect.just(.navigation(.present(.authentication(AuthenticationState()))))
        case .authenticationAction(.loggedIn):
            return .concatenate(
                Effect.just(.navigation(.dismiss)),
                Effect.just(.navigation(.push(.main(MainScreenState()))))
            )
        case .mainScreenAction(.showNavigationScreen1):
            return Effect.just(.navigation(.push(.forecast(ForecastState()))))
        case .mainScreenAction(.showNavigationScreen2):
            return Effect.just(.navigation(.present(.settings(SettingsState()))))
        case .forecastAction(.logout):
            return .concatenate(
                Effect.just(.navigation(.popToRoot)),
                Effect.just(.navigation(.present(.authentication(AuthenticationState()))))
            )
        case .forecastAction(.add(let id)):
            return .concatenate(
                Effect.just(.mainScreenAction(.add(id))),
                Effect.just(.navigation(.pop))
            )
        case .settingsAction(.close):
            return Effect.just(.navigation(.dismiss))
        case .settingsAction(.myAccountDidRequestLogout):
                // Pop to root and present authentication
                return .concatenate(
                    Effect.just(.navigation(.popToRoot)),
                    Effect.just(.navigation(.present(.authentication(AuthenticationState()))))
                )
        default:
            return .none
        }
    }
)

