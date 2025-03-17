//
//  ForecastReducer.swift
//  TCA
//
//  Created by Gohar Vardanyan on 11.03.25.
//

import Combine

final class ForecastReducer: ObservableObject, Reducer {
    final class ForecastState: ReducerState {}
    
    enum ForecastScreenAction: Action {
        case add
        case logout
    }
    
    typealias State = ForecastState
    
    private var coordinator: NavigableNode
    @Published var state = ForecastState()
    var cancelables = Set<AnyCancellable>()
    
    init(coordinator: NavigableNode) {
        self.coordinator = coordinator
        self.coordinator.reducer = self
    }
    
    func send(_ action: Action) {
        guard let action = action as? ForecastScreenAction else { return }
        switch action {
        case .logout:
            coordinator.navigateAction(action: MainScreenReducer.MainScreenAction.logout)
        case .add:
            coordinator.navigateAction(action:  MainScreenReducer.MainScreenAction.add("Added"))
        }
    }
}
