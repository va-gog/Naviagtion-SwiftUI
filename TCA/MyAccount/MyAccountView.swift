//
//  MyAccountView.swift
//  TCA
//
//  Created by Gohar Vardanyan on 17.03.25.
//

import SwiftUI

struct MyAccountView: View {
    @ObservedObject var reducer: MyAccountViewReducer
    var body: some View {
        HStack(spacing: 20) {
            Button {
                reducer.send(MyAccountViewReducer.MyAccountAction.logout)
            } label: {
                Text("Logout")
                    .foregroundColor(.red)
                    .foregroundStyle(.secondary)
            }
            Button {
                reducer.send(MyAccountViewReducer.MyAccountAction.add)
            } label: {
                Text("Add")
                    .foregroundColor(.red)
                    .foregroundStyle(.secondary)
            }
        }
    }
}
