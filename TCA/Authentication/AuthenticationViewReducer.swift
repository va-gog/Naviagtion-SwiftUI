//
//  AuthenticationViewReducer.swift
//  TCA
//
//  Created by Gohar Vardanyan on 11.03.25.
//

import Combine

final class AuthenticationViewReducer: Reducer {
    final class AuthenticationState: ReducerState {}
    
    enum AuthViewReducerAction: Action {
        case loggedIn
    }
    
    typealias State = AuthenticationState
    
    private var coordinator: NavigableNode
    var state: State = AuthenticationViewReducer.AuthenticationState()
    var cancelables = Set<AnyCancellable>()
    
    init(coordinator: NavigableNode) {
        self.coordinator = coordinator
        self.coordinator.reducer = self
    }
    
    func send(_ action: Action) {
        guard let action = action as? AuthViewReducerAction else { return }
        switch action {
        case .loggedIn:
            coordinator.navigateAction(action: NavigationAction<WeatherAppScreen>.dismiss(coordinator.uuid))
            coordinator.navigateAction(action: NavigationAction<WeatherAppScreen>.push(WeatherAppScreen.main))
        }
    }
}
