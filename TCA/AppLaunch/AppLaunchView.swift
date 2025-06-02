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
    @ObservedObject var viewStore: ViewStore<AppLaunchState, AppAction>
    
    init() {
        let store = Store(
            initialState: AppLaunchState(),
            reducer: appLaunchReducer
        )
        self._store = StateObject(wrappedValue: store)
        self.viewStore = ViewStore(store: store)
    }
    
    var body: some View {
        NavigationStack(path: Binding(
            get: { viewStore.navigationState.navigationPath },
            set: { viewStore.send(.navigation(.setPath($0))) }
        )) {
            Group {
                if let root = viewStore.navigationState.navigationPath.first {
                    screenView(for: root)
                }
            }
            .navigationDestination(for: AppScreenState.self) { screen in
                screenView(for: screen)
            }
        }
        .onAppear {
            viewStore.send(.onAppear)
        }
        .fullScreenCover(
            item: Binding(
                get: { viewStore.navigationState.screenCoverState },
                set: { newValue in
                    viewStore.send(.navigation(.setScreenCoverState(newValue)))
                }
            )
        ) { screen in
            screenView(for: screen)
        }
    }
    
    @ViewBuilder
    func screenView(for screen: AppScreenState) -> some View {
        switch screen {
        case .locPermition(let state):
            LocationPermitionView(
                store: store.scope(
                    state: { _ in state },
                    action: { .locPermitionAction($0) }
                )
            )
        case .authentication(let state):
            AuthenticationView(
                store: store.scope(
                    state: { _ in state },
                    action: { .authenticationAction($0) }
                )
            )
        case .main(let state):
            MainScreenView(
                store: store.scope(
                    state: { _ in state },
                    action: { .mainScreenAction($0) }
                )
            )
        case .forecast(let state):
            ForecastView(
                store: store.scope(
                    state: { _ in state },
                    action: { .forecastAction($0) }
                )
            )
        case .settings(let state):
            SettingsView(
                store: store.scope(
                    state: { _ in state },
                    action: { .settingsAction($0) }
                )
            )
        }
    }
}
