//
//  TrickVariationView.swift
//  Skate App (iOS)
//
//  Created by Hubert Rzeminski on 22/12/2020.
//

import SwiftUI

struct TrickVariationView: View {
    
    //MARK: Variable Declerations
    //View data variables
    let variationType : String
    let isComplete : Bool
    
    //View variables
    let diameter : CGFloat
    let backgroundColor : Color = Color(red: 0.95, green: 0.32, blue: 0.34) // Red
    let textColor : Color = Color(red: 0.28, green: 0.32, blue: 0.37) // Black

    //MARK: Body
    var body: some View {
        ZStack{ //TODO: Make the difference between completed items more obvious
            Circle()
                .fill(isComplete ? backgroundColor : backgroundColor.opacity(0.75))
                .frame(width: diameter, height: diameter, alignment: .center)
            Text(variationType)
                .fontWeight(.bold)
                .font(.system(size: TrickViewModel().pickFontSize(diameter: diameter)))
                .foregroundColor(textColor)
        }
    }
}
