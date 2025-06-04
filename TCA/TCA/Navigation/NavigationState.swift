//
//  NavigationState.swift
//  TCA
//
//  Created by Gohar Vardanyan on 30.05.25.
//

protocol NavigationState {
    associatedtype ScreenState: State
    var navigationPath: [ScreenState] { get set }
    var screenCoverState: ScreenState? { get set }
}




