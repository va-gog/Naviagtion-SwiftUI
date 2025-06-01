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
        HStack(spacing: 20) {
            Button {
                viewStore.send(.didRequestLogout)
            } label: {
                Text("Logout")
                    .foregroundColor(.yellow)
                    .foregroundStyle(.secondary)
            }
            Button {
                viewStore.send(.remove("ID"))
            } label: {
                Text("Remove")
                    .foregroundColor(.yellow)
                    .foregroundStyle(.secondary)
            }
        }
    }
}
