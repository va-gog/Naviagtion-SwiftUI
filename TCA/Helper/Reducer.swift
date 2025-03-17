//
//  Reducer.swift
//  TCA
//
//  Created by Gohar Vardanyan on 11.03.25.
//

import SwiftUI
import Combine

protocol AppScreen: Hashable, Equatable { }
protocol ReducerState: ObservableObject {}

protocol Action { }

protocol Reducer: ObservableObject {
    associatedtype State: ReducerState
    
    var cancelables: Set<AnyCancellable> { get set }
    var state: State { get }
    
    func send(_ action: Action)
    func observableReducer()
}

extension Reducer {
    func observableReducer()  {
         state.objectWillChange
            .receive(on: RunLoop.main)
            .sink { [weak self] _ in
                (self?.objectWillChange as? ObservableObjectPublisher)?.send()
            }
            .store(in: &cancelables)
    }
}
