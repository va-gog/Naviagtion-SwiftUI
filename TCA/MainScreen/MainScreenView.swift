//
//  MainScreenView.swift
//  TCA
//
//  Created by Gohar Vardanyan on 11.03.25.
//

import SwiftUI

struct MainScreenView: View {
    @ObservedObject var reducer: MainScreenReducer
    
    var body: some View {
        VStack(spacing: 40) {
            Button {
                reducer.send(MainScreenReducer.MainScreenAction.showNavigationScreen1)
            } label: {
                Text("Push screen")
                    .padding()
                    .foregroundColor(.red)
                    .cornerRadius(10)
            }
            Button {
                reducer.send(MainScreenReducer.MainScreenAction.showNavigationScreen2)
            } label: {
                Text("Present new NavigationStack")
                    .padding()
                    .foregroundColor(.red)
                    .cornerRadius(10)
            }
            if let item = reducer.state.item {
                Text("\(item)")
                    .padding()
                    .foregroundColor(.blue)
                    .cornerRadius(10)
            }
        }
    }
}
