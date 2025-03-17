//
//  LocPermitionViewReducer.swift
//  TCA
//
//  Created by Gohar Vardanyan on 11.03.25.
//

import Combine

final class LocPermitionViewReducer: Reducer {
    final class LocPermitioState: ReducerState {}
    
    enum LocPermitionViewReducerAction: Action {
        case locationAccessPermited
    }
    
    typealias State = LocPermitioState
    
    private var coordinator: NavigableNode
    @Published var state: State = LocPermitioState()
    var cancelables = Set<AnyCancellable>()
    
    init(coordinator: NavigableNode) {
        self.coordinator = coordinator
        self.coordinator.reducer = self
    }
    
    func send(_ action: Action) {
        guard let action = action as? LocPermitionViewReducerAction else { return }
        switch action {
        case .locationAccessPermited:
            coordinator.navigateAction(action: NavigationAction<WeatherAppScreen>.dismiss(coordinator.uuid))
            coordinator.navigateAction(action: NavigationAction<WeatherAppScreen>.present(WeatherAppScreen.authentication))
        }
    }
}
