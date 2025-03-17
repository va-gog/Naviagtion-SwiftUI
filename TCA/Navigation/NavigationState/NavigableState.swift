//
//  NavigationState.swift
//  TCA
//
//  Created by Gohar Vardanyan on 11.03.25.
//

import SwiftUI
import Combine

protocol NavigableState: ObservableObject, NavigableNode {
    associatedtype Screen: AppScreen
    
    var path: NavigationPath { get set }
    var presentedScreen: PathItem<Screen>? { get set }
    var action: Action? { get }
    
    func send(action: Action)
    func navigationItem<ChildActoin: Action>(
        childActionType: ChildActoin.Type) -> NavigableNode
    
    func navigationState<ChildScreen: AppScreen, ChildActoin: Action>(
        childScreenType: ChildScreen.Type,
        childActionType: ChildActoin.Type) -> any NavigableState
}
