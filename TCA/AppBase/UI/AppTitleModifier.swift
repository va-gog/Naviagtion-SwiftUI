//
//  AppTitleModifier.swift
//  TCA
//
//  Created by Gohar Vardanyan on 02.06.25.
//

import SwiftUI

struct CustomTitleModifier: ViewModifier {
    var font: Font = .title2.bold()
    var color: Color = Color(red: 0.98, green: 0.54, blue: 0.50)
    var padding: CGFloat = 4
    var alignment: TextAlignment = .center

    func body(content: Content) -> some View {
        content
            .font(font)
            .foregroundColor(color)
            .padding(.bottom, padding)
            .multilineTextAlignment(alignment)
            .frame(maxWidth: .infinity, alignment: alignment == .center ? .center : (alignment == .leading ? .leading : .trailing))
    }
}
