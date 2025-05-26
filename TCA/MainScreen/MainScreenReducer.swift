////
////  MainScreenReducer.swift
////  TCA
////
////  Created by Gohar Vardanyan on 11.03.25.
////
//
//import Combine
//
//final class MainScreenReducer: Reducer {
//    final class MainState: ObservableObject, ReducerState {
//        @Published var item: String?
//    }
//    
//    enum MainScreenAction: Action, Equatable {
//        case logout
//        case add(String)
//        case showNavigationScreen1
//        case showNavigationScreen2
//    }
//    
//    typealias State = MainState
//    
//    private var coordinator: NavigableNode
//    @Published var state = MainState()
//    var cancelables = Set<AnyCancellable>()
//    
//    init(coordinator: NavigableNode) {
//        self.coordinator = coordinator
//        self.coordinator.reducer = self
//        observableReducer()
//    }
//    
//    func send(_ action: Action) {
//        guard let action = action as? MainScreenReducer.MainScreenAction else { return }
//        switch action {
//        case .showNavigationScreen1:
//            coordinator.navigateAction(action: NavigationAction<WeatherAppScreen>.push(WeatherAppScreen.forecast))
//        case .showNavigationScreen2:
//            coordinator.navigateAction(action: NavigationAction<WeatherAppScreen>.present(WeatherAppScreen.settings))
//        case .add(let id):
//            state.item = id
//        case .logout:
//            coordinator.navigateAction(action: NavigationAction<WeatherAppScreen>.pop(coordinator.uuid))
//            coordinator.navigateAction(action: NavigationAction<WeatherAppScreen>.present(WeatherAppScreen.authentication))
//        }
//    }
//}

import Foundation

struct MainScreenState: Equatable {
    var items: [String] = []
}

enum MainScreenAction: Equatable {
    case logout
    case add(String)
    case remove(String)
    case showNavigationScreen1
    case showNavigationScreen2
}

let mainScreenReducer = Reducer<MainScreenState, MainScreenAction, Void> { state, action, _ in
    switch action {
    case .showNavigationScreen1:
        return .none
    case .showNavigationScreen2:
        return .none
    case .add(let id):
        state.items.append(id)
        return .none
    case .remove(let id):
        state.items.removeAll { $0 == id }
        return .none
    case .logout:
        return .none
    }
}
