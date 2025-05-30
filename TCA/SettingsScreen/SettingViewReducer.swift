//
//  SettingsViewReducer.swift
//  TCA
//
//  Created by Gohar Vardanyan on 13.03.25.
//

import Combine
import Foundation

struct SettingsState: State {
    var id: UUID = UUID()
    var myAccountState: MyAccountState? = nil
}

enum SettingsViewAction: Equatable {
    case myAccount
    case myAccountAction(MyAccountAction)
    case close
    case myAccountDidRemove(String)
}

let settingsReducer = Reducer<SettingsState, SettingsViewAction, Void> { state, action, _ in
    switch action {
    case .myAccount:
        state.myAccountState = MyAccountState()
        return .none
    case .myAccountAction:
        return .none
    case .close:
        return .none
    case .myAccountDidRemove:
        return .none
    }
}
