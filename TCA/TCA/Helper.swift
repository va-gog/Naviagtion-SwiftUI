//
//  Helper.swift
//  TCA
//
//  Created by Gohar Vardanyan on 01.06.25.
//

import CasePaths

func forEachEnumCase<RootState, RootAction, EnumState, FeatureState, FeatureAction, Environment>(
    statePath: WritableKeyPath<RootState, [EnumState]>, //AppNavState [AppScreenState]
    casePath: CasePath<EnumState, FeatureState>, // AppScreenState mainscreenState
    actionPath: CasePath<RootAction, FeatureAction>,   // applaunchaction mainaction
    reducer: Reducer<FeatureState, FeatureAction, Environment> // minreducer
) -> Reducer<RootState, RootAction, Environment> {
    Reducer { state, action, environment in
        guard let featureAction = actionPath.extract(from: action) else { return .none }
        var effect: Effect<RootAction> = .none
        for i in state[keyPath: statePath].indices {
            if var featureState = casePath.extract(from: state[keyPath: statePath][i]) {
                let localEffect = reducer.reduce(&featureState, featureAction, environment)
                    .map(actionPath.embed)
                state[keyPath: statePath][i] = casePath.embed(featureState)
                effect = effect.merge(with: localEffect)
            }
        }
        return effect
    }
}

func forCaseInOptional<RootState, RootAction, EnumState, FeatureState, FeatureAction, Environment>(
    statePath: WritableKeyPath<RootState, EnumState?>,
    casePath: CasePath<EnumState, FeatureState>,
    actionPath: CasePath<RootAction, FeatureAction>,
    reducer: Reducer<FeatureState, FeatureAction, Environment>
) -> Reducer<RootState, RootAction, Environment> {
    Reducer { state, action, environment in
        guard let featureAction = actionPath.extract(from: action),
              var featureState = state[keyPath: statePath].flatMap({ casePath.extract(from: $0) })
        else { return .none }
        let effect = reducer.reduce(&featureState, featureAction, environment)
        state[keyPath: statePath] = casePath.embed(featureState)
        return effect.map(actionPath.embed)
    }
}
