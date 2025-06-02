//
//  ForecastView.swift
//  TCA
//
//  Created by Gohar Vardanyan on 11.03.25.
//

import SwiftUI

struct ForecastView: View {
    @ObservedObject var viewStore: ViewStore<ForecastState, ForecastAction>
    
    init(store: Store<ForecastState, ForecastAction>) {
        self.viewStore = ViewStore(store: store)
    }
    
    var body: some View {
        VStack(spacing: 20) {
            Text("ForecastView")
                .modifier(CustomTitleModifier())
            
            Button {
                viewStore.send(.logout)
            } label: {
                Text("Logout")
            }
            .buttonStyle(AppButtonStyle())

            Button {
                viewStore.send(.add)
            } label: {
                Text("Add Item to Main screen")
            }
            .buttonStyle(AppButtonStyle())

        }
    }
}
