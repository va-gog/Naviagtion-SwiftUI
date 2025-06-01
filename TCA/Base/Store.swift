//
//  Store.swift
//  TCA
//
//  Created by Gohar Vardanyan on 16.05.25.
//

import Combine

final class Store<State, Action>: ObservableObject {
    @Published public private(set) var state: State
    private let reducer: Reducer<State, Action, Void>
    private var effectCancellables: Set<AnyCancellable> = []
    
    init(initialState: State, reducer: Reducer<State, Action, Void>) {
        self.state = initialState
        self.reducer = reducer
    }
    
    func send(_ action: Action) {
        let effect = reducer.reduce(&state, action, ())
        effect.publisher
            .sink(receiveValue: send)
            .store(in: &effectCancellables)
    }

    // TCA-style scope for parent-child communication
    func scope<ChildState, ChildAction>(
        state toChildState: @escaping (State) -> ChildState?,
        action fromChildAction: @escaping (ChildAction) -> Action
    ) -> Store<ChildState, ChildAction> {
        let childStore = Store<ChildState, ChildAction>(
            initialState: toChildState(self.state)!,
            reducer: Reducer<ChildState, ChildAction, Void> { childState, childAction, _ in
                self.send(fromChildAction(childAction))
                return .none
            }
        )
        // Keep child state in sync with parent
        self.$state
            .map(toChildState)
            .compactMap { $0 }
            .assign(to: &childStore.$state)
        return childStore
    }
}
