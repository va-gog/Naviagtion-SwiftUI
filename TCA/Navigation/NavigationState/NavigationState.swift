//
//  NavigationState.swift
//  TCA
//
//  Created by Gohar Vardanyan on 11.03.25.
//

import SwiftUI
import Combine

final class NavigationState<Screen: AppScreen, ReducerAction: Action>: NavigableState {
    @Published var path: NavigationPath = NavigationPath()
    @Published var presentedScreen: PathItem<Screen>?
    @Published var action: Action? = nil

    var uuid = IdentifiableUUID()
    var parent: (any NavigableState)?
    var reducer: (any Reducer)?
    
    private var pathItems: [PathItem<Screen>] = []
    private var cancellables = Set<AnyCancellable>()
       
    init(actionPublisher: Published<Action?>.Publisher?) {
        actionPublisher?
            .sink { [weak self] action in
                guard let action = action as? ReducerAction else { return }
                self?.sendAction(action: action)
            }
            .store(in: &cancellables)
        $action.sink { [weak self] action in
            guard let action = action as? ReducerAction else { return }
            self?.sendAction(action: action)
        }
        .store(in: &cancellables)

    }
    
    func navigateAction(action: any Action) {
        parent?.send(action: action)
    }
    
    func send(action: any Action) {
        if let action = action as? NavigationAction<Screen> {
            switch action {
            case .push(let screen):
                push(screen)
            case .present(let screen):
                present(screen)
            case .pop(let id):
                pop(id)
            case .dismiss(let id):
                dismiss(id: id)
            }
        } else {
            defer { self.action = nil }
            self.action = action
            
        }
    }
    
    func navigationItem<ChildActoin: Action>(
        childActionType: ChildActoin.Type) -> NavigableNode {
            let coordinator = NavigationNode<ChildActoin>(actionPublisher: $action)
            coordinator.parent = self
            return coordinator
    }
    
    func navigationState<ChildScreen: AppScreen, ChildActoin: Action>(
        childScreenType: ChildScreen.Type,
        childActionType: ChildActoin.Type) -> any NavigableState {
            let coordinator = NavigationState<ChildScreen, ChildActoin>(actionPublisher: $action)
            coordinator.parent = self
            return coordinator
    }
        
    private func sendAction(action: ReducerAction) {
        reducer?.send(action)
    }
    
    private func present(_ screen: Screen) {
        presentedScreen = PathItem(screen: screen)
    }
    
    private func push(_ screen: Screen) {
        let item = PathItem(id: IdentifiableUUID(),
                            screen: screen)
        path.append(item)
        pathItems.append(item)
    }
    
    private func dismiss(id: IdentifiableUUID?) {
        presentedScreen = nil
        objectWillChange.send()
    }
    
    private func pop(_ id: IdentifiableUUID) {
        guard let index = pathItems.firstIndex(where: {$0.id == id }),
              path.count - index > 0 else { return }
        let removedCount = path.count - index
        pathItems.removeLast(removedCount)
        path.removeLast(removedCount)
        objectWillChange.send()
    }
}

