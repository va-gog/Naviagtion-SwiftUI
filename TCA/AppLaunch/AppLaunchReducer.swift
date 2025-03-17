//
//  AppLaunchReducer.swift
//  TCA
//
//  Created by Gohar Vardanyan on 11.03.25.
//

import SwiftUI
import Combine

final class AppLaunchReducer: Reducer {
    final class AppLaunchState: ReducerState {}
    
    enum AppLaunchAction: Action {
        case locationAccess
    }
    
    typealias State = AppLaunchState
    
    var coordinator: NavigationState<WeatherAppScreen, AppLaunchAction>
    var state = AppLaunchState()
    var cancelables = Set<AnyCancellable>()
    
    init(coordinator: NavigationState<WeatherAppScreen, AppLaunchAction>) {
        self.coordinator = coordinator
        self.coordinator.reducer = self
        self.coordinator.objectWillChange.sink { [weak self] _ in
            self?.objectWillChange.send()
        }
        .store(in: &cancelables)
    }
    
    func send(_ action: Action) {
        guard let action = action as? AppLaunchAction else { return }
        switch action {
        case .locationAccess:
            coordinator.send(action: NavigationAction.present(WeatherAppScreen.locationAccess))
        }
    }
}
