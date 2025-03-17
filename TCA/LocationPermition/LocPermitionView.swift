//
//  LocPermitionView.swift
//  TCA
//
//  Created by Gohar Vardanyan on 11.03.25.
//

import SwiftUI

struct LocPermitionView: View {
    @ObservedObject var reducer: LocPermitionViewReducer
    
    var body: some View {
        VStack {
            Text("Location access is required to use this feature.")
                .padding()
            Button(action: {
                reducer.send(LocPermitionViewReducer.LocPermitionViewReducerAction.locationAccessPermited)
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
