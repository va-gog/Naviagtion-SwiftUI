//
//  SettingsViewReducer.swift
//  TCA
//
//  Created by Gohar Vardanyan on 13.03.25.
//

import Combine
import Foundation

struct SettingsState: Equatable {
    var myAccountState: MyAccountState? = nil
}

enum SettingsViewAction: Equatable {
    case myAccount
    case myAccountAction(MyAccountAction)
    case close
    case myAccountDidRemove(String)
    
}

let settingsReducer = Reducer<SettingsState, SettingsViewAction, Void> { state, action, _ in
    switch action {
    case .myAccount:
        state.myAccountState = MyAccountState()
        return .none
    case .myAccountAction(.logout):
        state.myAccountState = nil
        return Effect.just(.close)
    case .myAccountAction(.remove(let id)):
        return Effect.just(.myAccountDidRemove(id))
    case .close:
        return .none
    case .myAccountDidRemove(_):
        return .none
    }
}

//final class SettingsViewReducer<NavState: NavigableState>: Reducer {
//    final class SettingsReducerState: ReducerState {}
//    
//    typealias State = SettingsReducerState
//    
//    var coordinator: NavState
//    var state = SettingsReducerState()
//    var cancelables = Set<AnyCancellable>()
//
//    init(coordinator: NavState) {
//        self.coordinator = coordinator
//        self.coordinator.reducer = self
//        self.coordinator.objectWillChange.sink { [weak self] _ in
//            self?.objectWillChange.send()
//        }
//        .store(in: &cancelables)
//    }
//
//    func send(_ action: Action) {
//        guard let action = action as? SettingsViewAction else { return }
//        switch action {
//        case .close:
//            coordinator.navigateAction(action: MainScreenReducer.MainScreenAction.logout)
//        case .myAccount:
//            coordinator.send(action: NavigationAction.push(SettingsNavigationScreen.myAccount))
//        case .logout(let mainScreenAction):
//            coordinator.navigateAction(action: mainScreenAction)
//        case .add(let mainScreenAction):
//            coordinator.navigateAction(action: mainScreenAction)
//        }
//    }
//}
//
