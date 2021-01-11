//
//  ThemeAnimationStyle.swift
//  Skate App (iOS)
//
//  Created by Hubert Rzeminski on 11/01/2021.
//

import SwiftUI

struct ThemeAnimationStyle: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            //.background(configuration.isPressed ? Color.green.opacity(0.5) : Color.green)
            //.cornerRadius(8)
            //.shadow(color: Color.gray, radius: 10, x: 0, y: 0)
            .scaleEffect(configuration.isPressed ? 0.9 : 1.0)
    }
}
