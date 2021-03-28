//
//  LoadingView.swift
//  Skate App (iOS)
//
//  Created by Hubert Rzeminski on 12/02/2021.
//

import SwiftUI

struct LoadingView: View {
    
    //MARK: Variable Declerations
    //Navigation variables
    @Binding var isLoading : Bool
    
    //View variables
    var fontSize : CGFloat {
        return width * 0.06
    }
    var barWidth : CGFloat {
        return width * 0.75
    }
    var barHeight : CGFloat {
        return height * 0.01
    }
    var imageHeight : CGFloat {
        return height * 0.4
    }
    let loadingBarColor : Color = Color(red: 0.95, green: 0.32, blue: 0.34) // Red
    let loadingBarOffsetAnimation : CGFloat = 110
    let loadingBarWidth : CGFloat = 30
    let titleOffset : CGFloat = 25
    let cornerRadius : CGFloat = 3
    var width: CGFloat = UIScreen.main.bounds.width
    var height: CGFloat = UIScreen.main.bounds.height
    
    //MARK: Body
    var body: some View { //TODO: Make this screen better
        VStack{
            Spacer()
            VStack{
                Text("Getting game ready!") // Title
                    .font(.system(size: fontSize, design: .monospaced))
                ZStack{
                    //Loading background
                    RoundedRectangle(cornerRadius: cornerRadius)
                        .stroke(Color(.systemGray5), lineWidth: 5)
                        .frame(width: barWidth, height: barHeight)
                    //Loading moving bar
                    RoundedRectangle(cornerRadius: cornerRadius)
                        .stroke(loadingBarColor, lineWidth: 10)
                        .frame(width: loadingBarWidth, height: barHeight)
                        .offset(x: isLoading ? loadingBarOffsetAnimation : -loadingBarOffsetAnimation)
                        .animation(Animation.linear(duration: 1).repeatForever(autoreverses: false))
                }
            }
            Spacer()
        }
    }
}
