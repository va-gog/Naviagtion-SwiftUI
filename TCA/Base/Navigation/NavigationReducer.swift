//
//  NavigationReduceer.swift
//  TCA
//
//  Created by Gohar Vardanyan on 30.05.25.
//

func navigationReducer<State: NavigationState>() -> Reducer<State, NavigationAction<State.ScreenState>, Void> {
    Reducer { state, action, _ in
        switch action {
        case .push(let screenState):
            state.navigationPath.append(screenState)
            state = state
            return .none
        case .pop:
            _ = state.navigationPath.popLast()
            return .none
        case .popToId(let id):
            if let idx = state.navigationPath.lastIndex(where: { $0.id == id }) {
                state.navigationPath = Array(state.navigationPath.prefix(through: idx))
            }
            return .none
        case .present(let coverState):
            state.screenCoverState = coverState
            return .none
        case .dismiss:
            state.screenCoverState = nil
            return .none
        case .setScreenCoverState(let coverState):
            state.screenCoverState = coverState
            return .none
        case .setPath(let path):
            state.navigationPath = path
            return .none
        case .popToRoot:
            state.navigationPath.removeAll()
            return .none
        }
    }
}
