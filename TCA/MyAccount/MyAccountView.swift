//
//  MyAccountView.swift
//  TCA
//
//  Created by Gohar Vardanyan on 17.03.25.
//

import SwiftUI

struct MyAccountView: View {
    @ObservedObject var viewStore: ViewStore<MyAccountState, MyAccountAction>
    
    init(store: Store<MyAccountState, MyAccountAction>) {
        self.viewStore = ViewStore(store: store)
    }
    
    var body: some View {
        VStack(spacing: 20) {
            if viewStore.isLoading {
                VStack(spacing: 8) {
                    ProgressView()
                    Text("Logging out...")
                        .font(.headline)
                        .foregroundColor(.gray)
                }
            }
            
            Button {
                viewStore.send(.didRequestLogout)
            } label: {
                Text("Logout")
            }
            .buttonStyle(AppButtonStyle())

            Button {
                viewStore.send(.didRequestRemove(1))
            } label: {
                Text("Remove Item from Main Screen")
            }
            .buttonStyle(AppButtonStyle())

        }
    }
}
