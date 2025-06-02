//
//  LocationPermitionViewReducer.swift
//  TCA
//
//  Created by Gohar Vardanyan on 11.03.25.

import Foundation

struct LocPermitionState: State {
    var id: UUID = UUID()
}

enum LocPermitionAction: Equatable {
    case locationAccessPermited
}

let locPermitionReducer = Reducer<LocPermitionState, LocPermitionAction, Void> { state, action, _ in
    switch action {
    default:
        return .none
    }
}
