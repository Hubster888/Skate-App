//
//  LearButtonEffect.swift
//  Skate App (iOS)
//
//  Created by Hubert Rzeminski on 13/01/2021.
//

import SwiftUI

struct LearnButtonEffectButtonStyle: PrimitiveButtonStyle {
    var image: Image
    var action: () -> Void
    
    func makeBody(configuration: PrimitiveButtonStyle.Configuration) -> some View {
        ButtonView(configuration: configuration, image: image, action: action)
    }
    
    struct ButtonView: View {
        @State private var pressed = false
        
        let configuration: PrimitiveButtonStyle.Configuration
        let image: Image
        var action: () -> Void
        
        var width: CGFloat {
            return UIScreen.main.bounds.width
        }
        
        var height: CGFloat {
            return UIScreen.main.bounds.height
        }
        
        var body: some View {
            return
                ZStack{
                    Rectangle()
                        .fill(self.pressed ? Color.gray.opacity(0.5) : Color(red: 0.95, green: 0.32, blue: 0.34, opacity: 0))
                        .frame(width: width, height: height * 0.16 + 7, alignment: .center)
                        .offset(y: height * -0.04 + 3.5)
                    HStack{
                        image
                            .resizable()
                            .clipShape(Circle())
                            .overlay(Circle().stroke(self.pressed ? Color.white : Color(red: 0.95, green: 0.32, blue: 0.34), lineWidth: self.pressed ? 8 : 4))
                            .shadow(radius: 7)
                            .frame(width: height * 0.16, height: height * 0.16)
                            .offset(x: width * 0.09)
                        Spacer()
                        configuration.label
                        Spacer()
                }
                .padding(.bottom, height * 0.075)
                .onLongPressGesture(minimumDuration: 0.2, maximumDistance: .infinity, pressing: { pressing in
                    withAnimation(.easeInOut(duration: 0.2)) {
                        self.pressed = pressing
                    }
                    if !pressing {
                        action()
                    }
                }, perform: {
                    print("Perform")
                })
                //.background(self.pressed ? Color.green.opacity(0.5) : Color.green)
                //.shadow(color: Color.gray, radius: 10, x: 0, y: 0)
                //.scaleEffect(self.pressed ? 0.9 : 1.0)
                }
                
        }
    }
}