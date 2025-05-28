import CasePaths

public struct Reducer<State, Action, Environment> {
    public let reduce: (inout State, Action, Environment) -> Effect<Action>
    
    public init(_ reduce: @escaping (inout State, Action, Environment) -> Effect<Action>) {
        self.reduce = reduce
    }
} 

public extension Reducer {
    func pullback<ParentState, ParentAction, ParentEnvironment>(
        state toChildState: WritableKeyPath<ParentState, State?>,
        action toChildAction: AnyCasePath<ParentAction, Action>,
        environment toChildEnvironment: @escaping (ParentEnvironment) -> Environment
    ) -> Reducer<ParentState, ParentAction, ParentEnvironment> {
        Reducer<ParentState, ParentAction, ParentEnvironment> { parentState, parentAction, parentEnv in
            guard let childAction = toChildAction.extract(from: parentAction),
                  parentState[keyPath: toChildState] != nil
            else { return .none }
            let effect = self.reduce(&parentState[keyPath: toChildState]!, childAction, toChildEnvironment(parentEnv))
            return effect.map(toChildAction.embed)
        }
    }
}

public extension Reducer {
    static func combine(_ reducers: Reducer...) -> Reducer {
        Reducer { state, action, environment in
            reducers.reduce(.none) { effect, reducer in
                let newEffect = reducer.reduce(&state, action, environment)
                return effect.merge(with: newEffect)
            }
        }
    }
}
