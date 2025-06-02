//
//  Reducers.swift
//  TCA
//
//  Created by Gohar Vardanyan on 02.06.25.
//

import CasePaths

let mainScreenForEach = forEachEnumCase(
    statePath: \AppNavigationState.navigationPath,
    casePath: /AppScreenState.main,
    actionPath: /AppAction.mainScreenAction,
    reducer: mainScreenReducer
)
let forecastForEach = forEachEnumCase(
    statePath: \AppNavigationState.navigationPath,
    casePath: /AppScreenState.forecast,
    actionPath: /AppAction.forecastAction,
    reducer: forecastReducer
)
let settingForScreenCover = forCaseInOptional(
    statePath: \AppNavigationState.screenCoverState,
    casePath: /AppScreenState.settings,
    actionPath: /AppAction.settingsAction,
    reducer: settingsReducer
)

let navReducer: Reducer<AppNavigationState, NavigationAction<AppScreenState>, Void> = navigationReducer()
