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
        
        NavigationStack(path: Binding(
            get: { viewStore.navigationState.navigationPath },
            set: { viewStore.send(.navigation(.setPath($0))) }
        )) {
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
                if viewStore.isLoading {
                    VStack(spacing: 8) {
                        ProgressView()
                        Text("Logging out...")
                            .font(.headline)
                            .foregroundColor(.gray)
                    }
                }
            }
            .navigationDestination(for: SettingsScreenState.self) { screen in
                switch screen {
                case .myAccount(let state):
                    MyAccountView(
                        store: store.scope(
                            state: { _ in state },
                            action: SettingsViewAction.myAccountAction
                        )
                    )
                }
            }
        }
    }
}
