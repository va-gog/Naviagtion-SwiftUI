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
            Button {
                viewStore.send(.showNavigationScreen1)
            } label: {
                Text("Push screen")
                    .padding()
                    .foregroundColor(.red)
                    .cornerRadius(10)
            }
            Button {
                viewStore.send(.showNavigationScreen2)
            } label: {
                Text("Present new NavigationStack")
                    .padding()
                    .foregroundColor(.red)
                    .cornerRadius(10)
            }
            ForEach(viewStore.items, id: \.self) { item in
                Text(item)
                    .padding()
                    .foregroundColor(.red)
                    .cornerRadius(10)
            }
        }
    }
}
