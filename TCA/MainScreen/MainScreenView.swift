//
//  MainScreenView.swift
//  TCA
//
//  Created by Gohar Vardanyan on 11.03.25.

import SwiftUI

struct MainScreenView: View {
    @ObservedObject var viewStore: ViewStore<MainScreenState, MainScreenAction>
    
    init(store: Store<MainScreenState, MainScreenAction>) {
        self.viewStore = ViewStore(store: store)
    }
    
    var body: some View {
        VStack(spacing: 40) {
            Text("Main Screen")
                .modifier(CustomTitleModifier())
            
            Button {
                viewStore.send(.pushForecastView)
            } label: {
                Text("Push Forecast Screen")
            }
            .buttonStyle(AppButtonStyle())

            Button {
                viewStore.send(.presentSettingsView)
            } label: {
                Text("Present Settings Screen")
            }
            .buttonStyle(AppButtonStyle())

            ForEach(viewStore.items, id: \.self) { item in
                Text("New Added \(item.name)")
                    .padding()
                    .foregroundColor(.red)
                    .cornerRadius(10)
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}
