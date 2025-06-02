//
//  ViewStore.swift
//  TCA
//
//  Created by Gohar Vardanyan on 16.05.25.
//

import Combine

@dynamicMemberLookup
public final class ViewStore<State, Action>: ObservableObject {
    @Published public private(set) var state: State
    private let sendAction: (Action) -> Void
    private var cancellable: AnyCancellable?
    
    init(store: Store<State, Action>) {
        self.state = store.state
        self.sendAction = store.send
        self.cancellable = store.$state.sink { [weak self] in self?.state = $0 }
    }
    
    func send(_ action: Action) {
        sendAction(action)
    }
    
    subscript<T>(dynamicMember keyPath: KeyPath<State, T>) -> T {
        state[keyPath: keyPath]
    }
} 
