//
//  MainScreenReducer.swift
//  TCA
//
//  Created by Gohar Vardanyan on 11.03.25.
//

import Foundation

struct MainScreenState: State {
    var id: UUID = UUID()
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
