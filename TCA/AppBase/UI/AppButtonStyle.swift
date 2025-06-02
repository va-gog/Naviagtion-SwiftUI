//
//  AppButton.swift
//  TCA
//
//  Created by Gohar Vardanyan on 02.06.25.
//

import SwiftUI

struct AppButtonStyle: ButtonStyle {
    var background: Color = Color(red: 0.93, green: 0.96, blue: 0.99)
    var foreground: Color = Color(red: 0.18, green: 0.40, blue: 0.80)
    var borderColor: Color = Color(red: 0.60, green: 0.80, blue: 1.00)
    var borderWidth: CGFloat = 2

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(.vertical, 12)
            .padding(.horizontal, 24)
            .background(background)
            .foregroundColor(foreground)
            .font(.headline)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(borderColor, lineWidth: borderWidth)
            )
            .cornerRadius(10)
            .shadow(color: .black.opacity(configuration.isPressed ? 0.05 : 0.10), radius: 3, x: 0, y: 1)
            .scaleEffect(configuration.isPressed ? 0.97 : 1.0)
            .opacity(configuration.isPressed ? 0.85 : 1.0)
            .animation(.easeOut(duration: 0.15), value: configuration.isPressed)
    }
}
