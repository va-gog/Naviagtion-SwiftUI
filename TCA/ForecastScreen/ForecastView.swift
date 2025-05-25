////
////  ForecastView.swift
////  TCA
////
////  Created by Gohar Vardanyan on 11.03.25.
////
//
//import SwiftUI
//
//struct ForecastView: View {
//    @ObservedObject var reducer: ForecastReducer
//    var body: some View {
//        HStack(spacing: 20) {
//            Button {
//                reducer.send(ForecastReducer.ForecastScreenAction.logout)
//            } label: {
//                Text("Logout")
//                    .foregroundColor(.red)
//                    .foregroundStyle(.secondary)
//            }
//            Button {
//                reducer.send(ForecastReducer.ForecastScreenAction.add)
//            } label: {
//                Text("Add")
//                    .foregroundColor(.red)
//                    .foregroundStyle(.secondary)
//            }
//        }
//    }
//}

import SwiftUI

struct ForecastView: View {
    @ObservedObject var viewStore: ViewStore<ForecastState, ForecastAction>
    
    init(store: Store<ForecastState, ForecastAction>) {
        self.viewStore = ViewStore(store: store)
    }
    
    var body: some View {
        HStack(spacing: 20) {
            Button {
                viewStore.send(.logout)
            } label: {
                Text("Logout")
                    .foregroundColor(.red)
                    .foregroundStyle(.secondary)
            }
            Button {
                viewStore.send(.add("Added"))
            } label: {
                Text("Add")
                    .foregroundColor(.red)
                    .foregroundStyle(.secondary)
            }
        }
    }
}
