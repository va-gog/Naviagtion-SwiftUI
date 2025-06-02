//
//  ForecastReducer.swift
//  TCA
//
//  Created by Gohar Vardanyan on 11.03.25.
//

import Foundation

struct ForecastItemModel: Hashable {
    var id: Int
    var name: String
}

struct ForecastState: State {
    var id: UUID = UUID()
}

enum ForecastAction: Equatable {
    case add
    case logout
    case addItem(ForecastItemModel)
}

let forecastReducer = Reducer<ForecastState, ForecastAction, Void> { state, action, _ in
    switch action {
    case .add:
        return Effect.just(.addItem(ForecastItemModel(id: 1, name: "Added Item")))
    default:
        return .none
    }
}
