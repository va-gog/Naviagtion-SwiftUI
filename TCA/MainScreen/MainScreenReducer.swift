//
//  MainScreenReducer.swift
//  TCA
//
//  Created by Gohar Vardanyan on 11.03.25.
//

import Foundation

struct MainScreenState: State {
    var id: UUID = UUID()
    var items: [ForecastItemModel] = []
}

enum MainScreenAction: Equatable {
    case add(ForecastItemModel)
    case remove(Int)
    case pushForecastView
    case presentSettingsView
}

let mainScreenReducer = Reducer<MainScreenState, MainScreenAction, Void> { state, action, _ in
    switch action {
    case .add(let item):
        state.items.append(item)
        return .none
    case .remove(let id):
        state.items.removeAll { $0.id == id }
        return .none
    default:
        return .none
    }
    
}
