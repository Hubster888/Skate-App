//
//  LoadingView.swift
//  Skate App (iOS)
//
//  Created by Hubert Rzeminski on 12/02/2021.
//

import SwiftUI

struct LoadingView: View {
    
    @State var isLoading : Bool = true
    let width = LearnView().width
    let height = LearnView().height
    
    var body: some View {
        VStack{
            Spacer()
            ZStack{
                Text("Getting plan ready!")
                    .font(.system(size: 20, design: .rounded))
                    .bold()
                    .offset(x: 0, y: -25)
                 
                RoundedRectangle(cornerRadius: 3)
                    .stroke(Color(.systemGray5), lineWidth: 3)
                    .frame(width: 250, height: 3)
                 
                RoundedRectangle(cornerRadius: 3)
                    .stroke(Color(red: 0.95, green: 0.32, blue: 0.34), lineWidth: 3)
                    .frame(width: 30, height: 3)
                    .offset(x: isLoading ? 110 : -110, y: 0)
                    .animation(Animation.linear(duration: 1).repeatForever(autoreverses: false))
                    
            }
            Spacer()
            Image("skatePicModed")
                .resizable()
                .frame(width: width, height: height * 0.4, alignment: .bottom)
                .offset(y: height * 0.05)
        }
    }
}
