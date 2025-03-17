//
//  ForecastView.swift
//  TCA
//
//  Created by Gohar Vardanyan on 11.03.25.
//

import SwiftUI

struct ForecastView: View {
    @ObservedObject var reducer: ForecastReducer
    var body: some View {
        HStack(spacing: 20) {
            Button {
                reducer.send(ForecastReducer.ForecastScreenAction.logout)
            } label: {
                Text("Logout")
                    .foregroundColor(.red)
                    .foregroundStyle(.secondary)
            }
            Button {
                reducer.send(ForecastReducer.ForecastScreenAction.add)
            } label: {
                Text("Add")
                    .foregroundColor(.red)
                    .foregroundStyle(.secondary)
            }
        }
    }
}
