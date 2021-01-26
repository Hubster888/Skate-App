//
//  GradientButtonStyle.swift
//  Skate App (iOS)
//
//  Created by Hubert Rzeminski on 14/01/2021.
//

import Foundation
import SwiftUI

struct GradientButtonStyle: ButtonStyle {
    
    let mainColor : Color
    let secondColor : Color
    
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .foregroundColor(Color.white)
            .padding()
            .background(LinearGradient(gradient: Gradient(colors: [mainColor, secondColor]), startPoint: .leading, endPoint: .trailing))
            .cornerRadius(15.0)
    }
}
