//
//  NavigationAction.swift
//  TCA
//
//  Created by Gohar Vardanyan on 11.03.25.
//

enum NavigationAction<Screen: AppScreen>: Action  {
    case push(Screen)
    case pop(IdentifiableUUID)
    case present(Screen)
    case dismiss(IdentifiableUUID)
}
