//
//  PathItem.swift
//  TCA
//
//  Created by Gohar Vardanyan on 17.03.25.
//

struct PathItem<Screen: AppScreen>: Hashable, Identifiable {
    var id = IdentifiableUUID()
    var screen: Screen
}
