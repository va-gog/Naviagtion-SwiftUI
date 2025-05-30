//
//  SettingsView.swift
//  TCA
//
//  Created by Gohar Vardanyan on 13.03.25.
//

import SwiftUI

struct SettingsView: View {
    @ObservedObject var viewStore: ViewStore<SettingsState, SettingsViewAction>
    let store: Store<SettingsState, SettingsViewAction>
    
    init(store: Store<SettingsState, SettingsViewAction>) {
        self.store = store
        self.viewStore = ViewStore(store: store)
    }
    
    var body: some View {
        VStack(spacing: 20) {
            Text("This is a Presented Screen which contains New Navigation Stack")
                .foregroundColor(.red)
                .foregroundStyle(.primary)
                .frame(maxWidth: .infinity, alignment: .center)
                .multilineTextAlignment(.center)
            Button {
                viewStore.send(.close)
            } label: {
                Text("Close")
                    .foregroundColor(.blue)
                    .foregroundStyle(.secondary)
            }
            Button {
                viewStore.send(.myAccount)
            } label: {
                Text("My Accouunt")
                    .foregroundColor(.blue)
                    .foregroundStyle(.secondary)
            }
            if viewStore.myAccountState != nil {
                MyAccountView(
                    store: store.scope(
                        state: { $0.myAccountState },
                        action: SettingsViewAction.myAccountAction
                    )
                )
            }
        }
    }
}
