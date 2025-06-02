//
//  NavigationAction.swift
//  TCA
//
//  Created by Gohar Vardanyan on 11.03.25.
//

import Foundation

enum NavigationAction<ScreenState: Hashable>: Hashable {
    case push(ScreenState)
    case pop
    case popToId(UUID)
    case setPath([ScreenState])
    case present(ScreenState)
    case dismiss
    case setScreenCoverState(ScreenState?)
    case popToRoot
}
