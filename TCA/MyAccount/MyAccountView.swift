////
////  MyAccountView.swift
////  TCA
////
////  Created by Gohar Vardanyan on 17.03.25.
////
//
//import SwiftUI
//
//struct MyAccountView: View {
//    @ObservedObject var reducer: MyAccountViewReducer
//    var body: some View {
//        HStack(spacing: 20) {
//            Button {
//                reducer.send(MyAccountViewReducer.MyAccountAction.logout)
//            } label: {
//                Text("Logout")
//                    .foregroundColor(.red)
//                    .foregroundStyle(.secondary)
//            }
//            Button {
//                reducer.send(MyAccountViewReducer.MyAccountAction.add)
//            } label: {
//                Text("Add")
//                    .foregroundColor(.red)
//                    .foregroundStyle(.secondary)
//            }
//        }
//    }
//}

import SwiftUI

struct MyAccountView: View {
    @ObservedObject var viewStore: ViewStore<MyAccountState, MyAccountAction>
    
    init(store: Store<MyAccountState, MyAccountAction>) {
        self.viewStore = ViewStore(store: store)
    }
    
    var body: some View {
        HStack(spacing: 20) {
            Button {
                viewStore.send(.logout)
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
