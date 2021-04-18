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
    let cornerRadius : CGFloat = 25
    var width: CGFloat = UIScreen.main.bounds.width
    var height: CGFloat = UIScreen.main.bounds.height
    
    //MARK: Body
    var body: some View { //TODO: Make this screen better
        VStack{
            Spacer()
            AnimatedImageView(fileName: "skateLoading") // skateboard GIF
                .frame(width: width * 0.8, height: height/2, alignment: .center)
                .cornerRadius(cornerRadius)
                .scaledToFit()
                .shadow(radius: 15)
            Spacer()
            Text("LOADING...")
                .font(.largeTitle)
            Spacer()
        }
    }
}
