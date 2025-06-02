//
//  LocationPermitionView.swift
//  TCA
//
//  Created by Gohar Vardanyan on 11.03.25.

import SwiftUI

struct LocationPermitionView: View {
    @ObservedObject var viewStore: ViewStore<LocPermitionState, LocPermitionAction>
    
    init(store: Store<LocPermitionState, LocPermitionAction>) {
        self.viewStore = ViewStore(store: store)
    }
    
    var body: some View {
        VStack {
            Text("Location access is required to use this feature.")
                .padding()
            Button(action: {
                viewStore.send(.locationAccessPermited)
            }) {
                Text("Open Settings")
                    .foregroundColor(.blue)
                    .padding()
                    .background(Color(.systemGray5))
                    .cornerRadius(10)
            }
        }
    }
}
