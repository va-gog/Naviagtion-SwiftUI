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
                if viewStore.isLoading {
                    VStack(spacing: 8) {
                        ProgressView()
                        Text("Logging out...")
                            .font(.headline)
                            .foregroundColor(.gray)
                    }
                }
                
                Text("SettingsView is a Presented Screen which contains its own Navigation Stack")
                    .modifier(CustomTitleModifier(font: .body))
                
                Button {
                    viewStore.send(.close)
                } label: {
                    Text("Close Settings View")
                }
                .buttonStyle(AppButtonStyle())
                
                Button {
                    viewStore.send(.myAccount)
                } label: {
                    Text("Push My Accouunt")
                }
                .buttonStyle(AppButtonStyle())
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
