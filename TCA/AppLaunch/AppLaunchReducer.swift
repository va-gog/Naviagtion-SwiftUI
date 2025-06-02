//
//  AppLaunchReducer.swift
//  TCA
//
//  Created by Gohar Vardanyan on 11.03.25.
//

import Foundation
import Combine
import CasePaths

struct AppLaunchState: State {
    var id: UUID = UUID()
    var navigationState = AppNavigationState()
}

enum AppAction: Equatable {
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

let appLaunchReducer: Reducer<AppLaunchState, AppAction, Void> = Reducer.combine(
    navReducer.pullback(
        state: \.navigationState,
        action: /AppAction.navigation,
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
    
    Reducer<AppLaunchState, AppAction, Void> { state, action, _ in
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
        case .mainScreenAction(.pushForecastView):
            return Effect.just(.navigation(.push(.forecast(ForecastState()))))
        case .mainScreenAction(.presentSettingsView):
            return Effect.just(.navigation(.present(.settings(SettingsState()))))
        case .forecastAction(.logout):
            return .concatenate(
                Effect.just(.navigation(.popToRoot)),
                Effect.just(.navigation(.present(.authentication(AuthenticationState()))))
            )
        case .forecastAction(.addItem(let item)):
            return .concatenate(
                Effect.just(.mainScreenAction(.add(item))),
                Effect.just(.navigation(.pop))
            )
        case .settingsAction(.close):
            return Effect.just(.navigation(.dismiss))
        case .settingsAction(.myAccountDidRequestLogout):
                return .concatenate(
                    Effect.just(.navigation(.popToRoot)),
                    Effect.just(.navigation(.present(.authentication(AuthenticationState()))))
                )
        case .settingsAction(.myAccountDidRequestRemove(let id)):
            return .concatenate(
                Effect.just(.navigation(.dismiss)),
                Effect.just(.mainScreenAction(.remove(id)))
                )
        default:
            return .none
        }
    }
)

