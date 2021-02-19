//
//  Arc.swift
//  Skate App (iOS)
//
//  Created by Hubert Rzeminski on 28/01/2021.
//

import SwiftUI

struct Arc: Shape {
    /*var startAngle: Angle
    var endAngle: Angle
    var clockwise: Bool*/
    private let startAngle: Double = 0.0
    private var endAngle: Double {
        get {
            return self.startAngle + Double.pi * 2 * self.progress
        }
    }
    
    var progress: Double = 0.0
    var animatableData: Double {
        get {
            self.progress
        }
        set {
            self.progress = newValue
        }
    }

    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.addArc(center: CGPoint(x: rect.midX, y: rect.midY), radius: rect.width / 2, startAngle: .degrees(endAngle), endAngle: .degrees(0), clockwise: true)

        return path
    }
}


