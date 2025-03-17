//
//  SettingsViewAction.swift
//  TCA
//
//  Created by Gohar Vardanyan on 17.03.25.
//

enum SettingsViewAction: Action {
    case close
    case myAccount
    case logout(MainScreenReducer.MainScreenAction)
    case add(MainScreenReducer.MainScreenAction)

}
