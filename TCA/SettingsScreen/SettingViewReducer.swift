//
//  SettingsViewReducer.swift
//  TCA
//
//  Created by Gohar Vardanyan on 13.03.25.
//

import Combine

final class SettingsViewReducer<NavState: NavigableState>: Reducer {
    final class SettingsReducerState: ReducerState {}
    
    typealias State = SettingsReducerState
    
    var coordinator: NavState
    var state = SettingsReducerState()
    var cancelables = Set<AnyCancellable>()

    init(coordinator: NavState) {
        self.coordinator = coordinator
        self.coordinator.reducer = self
        self.coordinator.objectWillChange.sink { [weak self] _ in
            self?.objectWillChange.send()
        }
        .store(in: &cancelables)
    }

    func send(_ action: Action) {
        guard let action = action as? SettingsViewAction else { return }
        switch action {
        case .close:
            coordinator.navigateAction(action: MainScreenReducer.MainScreenAction.logout)
        case .myAccount:
            coordinator.send(action: NavigationAction.push(SettingsNavigationScreen.myAccount))
        case .logout(let mainScreenAction):
            coordinator.navigateAction(action: mainScreenAction)
        case .add(let mainScreenAction):
            coordinator.navigateAction(action: mainScreenAction)
        }
    }
}

