//
//  NavigationNode.swift
//  TCA
//
//  Created by Gohar Vardanyan on 11.03.25.
//

import SwiftUI
import Combine

final class NavigationNode<ReducerAction: Action>: NavigableNode {
    var uuid = IdentifiableUUID()
    weak var parent: (any NavigableState)?
    weak var reducer: (any Reducer)?
    
    private var cancellables = Set<AnyCancellable>()
       
    init(actionPublisher: Published<Action?>.Publisher?) {
        actionPublisher?
            .sink { [weak self] action in
                guard let action = action as? ReducerAction else { return }
                self?.sendAction(action: action)
            }
            .store(in: &cancellables)
    }
    
    func navigateAction(action: any Action) {
        parent?.send(action: action)
    }
    
    private func sendAction(action: ReducerAction) {
        reducer?.send(action)
    }
}
