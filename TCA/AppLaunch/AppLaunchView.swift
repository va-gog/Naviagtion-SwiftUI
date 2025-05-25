//
//  AppLaunchView.swift
//  TCA
//
//  Created by Gohar Vardanyan on 11.03.25.
//

import SwiftUI

struct AppLaunchView: View {
    @StateObject var store = Store(
        initialState: AppLaunchState(),
        reducer: appLaunchReducer
    )
    @ObservedObject var viewStore: ViewStore<AppLaunchState, AppLaunchAction>
    
    init() {
        let store = Store(
            initialState: AppLaunchState(),
            reducer: appLaunchReducer
        )
        self._store = StateObject(wrappedValue: store)
        self.viewStore = ViewStore(store: store)
    }
    
    var body: some View {
        ZStack {
            Color.white.ignoresSafeArea()
            if viewStore.locPermitionState != nil {
                LocPermitionView(
                    store: store.scope(
                        state: { $0.locPermitionState },
                        action: AppLaunchAction.locPermitionAction
                    )
                )
            } else if viewStore.authenticationState != nil {
                AuthenticView(
                    store: store.scope(
                        state: { $0.authenticationState },
                        action: AppLaunchAction.authenticationAction
                    )
                )
            } else if viewStore.mainScreenState != nil {
                MainScreenView(
                    store: store.scope(
                        state: { $0.mainScreenState },
                        action: AppLaunchAction.mainScreenAction
                    )
                )
            }
            if viewStore.forecastState != nil {
                ForecastView(
                    store: store.scope(
                        state: { $0.forecastState },
                        action: AppLaunchAction.forecastAction
                    )
                )
            }
            if viewStore.settingsState != nil {
                SettingsView(
                    store: store.scope(
                        state: { $0.settingsState },
                        action: AppLaunchAction.settingsAction
                    )
                )
            }
        }
        .onAppear {
            viewStore.send(.onAppear)
        }
    }
}
