//
//  SettingsView.swift
//  TCA
//
//  Created by Gohar Vardanyan on 13.03.25.
//

import SwiftUI

struct SettingsView: View {
    @ObservedObject var reducer: SettingsViewReducer<NavigationState<SettingsNavigationScreen, SettingsViewAction>>
   
    var body: some View {
        NavigationStack(path: $reducer.coordinator.path) {
            VStack(spacing: 20) {
                Text("This is a Presented Screen which contains New Navigation Stack")
                    .foregroundColor(.red)
                    .foregroundStyle(.primary)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .multilineTextAlignment(.center)
                Button {
                    reducer.send(SettingsViewAction.close)
                } label: {
                    Text("Close")
                        .foregroundColor(.blue)
                        .foregroundStyle(.secondary)
                }
                Button {
                    reducer.send(SettingsViewAction.myAccount)
                } label: {
                    Text("My Accouunt")
                        .foregroundColor(.blue)
                        .foregroundStyle(.secondary)
                }
            }
            .navigationDestination(for: PathItem<SettingsNavigationScreen>.self) { item in
                AnyView(buildView(pathItem: item))
            }
        }
        .fullScreenCover(item: $reducer.coordinator.presentedScreen) {  item in
            AnyView(buildView(pathItem: item))
        }
    }
    
    private func buildView(pathItem: PathItem<SettingsNavigationScreen>) -> any View {
        switch pathItem.screen {
        case SettingsNavigationScreen.myAccount:
            let coordinator = reducer.coordinator.navigationItem(childActionType: MyAccountViewReducer.MyAccountAction.self)
            let reducer = MyAccountViewReducer(coordinator: coordinator)
            return MyAccountView(reducer: reducer)
                .navigationTitle("My Account")
        }
    }
}
