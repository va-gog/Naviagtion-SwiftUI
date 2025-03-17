//
//  MyAccountViewReducer.swift
//  TCA
//
//  Created by Gohar Vardanyan on 17.03.25.
//

import Combine

final class MyAccountViewReducer: ObservableObject, Reducer {
    final class MyAccountState: ReducerState {}
    
    enum MyAccountAction: Action {
        case add
        case logout
    }
    
    typealias State = MyAccountState
    
    private var coordinator: NavigableNode
    @Published var state = MyAccountState()
    var cancelables = Set<AnyCancellable>()
    
    init(coordinator: NavigableNode) {
        self.coordinator = coordinator
        self.coordinator.reducer = self
    }
    
    func send(_ action: Action) {
        guard let action = action as? MyAccountAction else { return }
        switch action {
        case .logout:
            coordinator.navigateAction(action: SettingsViewAction.logout(MainScreenReducer.MainScreenAction.logout))
        case .add:
            coordinator.navigateAction(action: SettingsViewAction.logout(MainScreenReducer.MainScreenAction.add("Added from MyAccount")))
        }
    }
}
