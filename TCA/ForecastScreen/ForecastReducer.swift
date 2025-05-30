//
//  ForecastReducer.swift
//  TCA
//
//  Created by Gohar Vardanyan on 11.03.25.
//

import Foundation

struct ForecastState: State {
    var id: UUID = UUID()
}

enum ForecastAction: Equatable {
    case add(String)
    case logout
}

let forecastReducer = Reducer<ForecastState, ForecastAction, Void> { state, action, _ in
    switch action {
    case .logout:
        return .none
    case .add(_):
        return .none
    }
}
