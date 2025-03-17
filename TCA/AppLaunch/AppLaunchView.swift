//
//  AppLaunchView.swift
//  TCA
//
//  Created by Gohar Vardanyan on 11.03.25.
//

import SwiftUI

struct AppLaunchView: View {
    @StateObject var reducer: AppLaunchReducer = AppLaunchReducer(coordinator: NavigationState<WeatherAppScreen, AppLaunchReducer.AppLaunchAction>(actionPublisher: nil))
    
    var body: some View {
        NavigationStack(path: $reducer.coordinator.path) {
            EmptyView()
            .navigationDestination(for: PathItem<WeatherAppScreen>.self) { item in
                AnyView(buildView(pathItem: item))
            }
        }
        .fullScreenCover(item: $reducer.coordinator.presentedScreen) {  item in
            AnyView(buildView(pathItem: item))
        }
        .onAppear() {
            reducer.send(AppLaunchReducer.AppLaunchAction.locationAccess)
        }
    }
    
    private func buildView(pathItem: PathItem<WeatherAppScreen>) -> any View {
        switch pathItem.screen {
        case WeatherAppScreen.locationAccess:
            let coordinator = reducer.coordinator.navigationItem(childActionType: LocPermitionViewReducer.LocPermitionViewReducerAction.self)
            let reducer = LocPermitionViewReducer(coordinator: coordinator)
            return LocPermitionView(reducer: reducer)
            
        case WeatherAppScreen.authentication:
            let coordinator = reducer.coordinator.navigationItem(childActionType: AuthenticationViewReducer.AuthViewReducerAction.self)
            let reducer = AuthenticationViewReducer(coordinator: coordinator)
            return AuthenticView(reducer: reducer)
            
        case WeatherAppScreen.main:
            let coordinator = reducer.coordinator.navigationItem(childActionType: MainScreenReducer.MainScreenAction.self)
            let reducer = MainScreenReducer(coordinator: coordinator)
            return MainScreenView(reducer: reducer)
            
        case WeatherAppScreen.forecast:
            let coordinator = reducer.coordinator.navigationItem(childActionType: ForecastReducer.ForecastScreenAction.self)
            let reducer = ForecastReducer(coordinator: coordinator)
            return ForecastView(reducer: reducer)
            
        case WeatherAppScreen.settings:
            guard let coordinator = reducer.coordinator.navigationState(childScreenType: SettingsNavigationScreen.self,
                                                                        childActionType: SettingsViewAction.self) as? NavigationState<SettingsNavigationScreen, SettingsViewAction> else { return EmptyView() }
            let reducer = SettingsViewReducer(coordinator: coordinator)
            return SettingsView(reducer: reducer)
        }
    }
}
