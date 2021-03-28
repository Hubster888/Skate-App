//
//  LoadingPlaceHolder.swift
//  Skate App (iOS)
//
//  Created by Hubert Rzeminski on 23/03/2021.
//

import SwiftUI

struct LoadingPlaceHolder: View {
    @State var isLoading = false
    var width : CGFloat
    var height : CGFloat
    var backgroundColor : Color
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(backgroundColor)
                .frame(width: width, height: height, alignment: .center)

            Circle()
                .stroke(Color(.systemGray5), lineWidth: 14)
                .frame(width: 100, height: 100)
 
            Circle()
                .trim(from: 0, to: 0.2)
                .stroke(Color.red, lineWidth: 7)
                .frame(width: 100, height: 100)
                .rotationEffect(Angle(degrees: isLoading ? 360 : 0))
                .animation(Animation.linear(duration: 1).repeatForever(autoreverses: false))
                .onAppear() {
                    self.isLoading = true
            }
        }
    }
}

