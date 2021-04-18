//
//  GameListElm.swift
//  Skate App (iOS)
//
//  Created by Hubert Rzeminski on 14/01/2021.
//

import SwiftUI

struct GameListElm: View {
    
    //MARK: Variable declerations
    //Related data varialbes
    let name : String
    let avaliable : Bool
    
    
    let height : CGFloat = UIScreen.main.bounds.height
    let width : CGFloat = UIScreen.main.bounds.width
    
    
    //MARK: Body
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 25)
                .fill(Color.red)
                .frame(width: width * 0.4, height: height * 0.3, alignment: .center)
                .shadow(radius: 15)
            VStack{
                Spacer()
                ZStack{
                    Image("gameIcon1")
                        .resizable()
                        .scaledToFit()
                        .padding(width * 0.05)
                    ZStack{
                        Rectangle()
                            .fill(Color.black.opacity(avaliable ? 0 : 0.7))
                            .frame(width: width * 0.4, height: height * 0.1, alignment: .center)
                        Text("Coming Soon!").opacity(avaliable ? 0 : 1)
                            .foregroundColor(Color.white)
                    }
                }
                Spacer()
                Text(name)
                    .font(.title2)
                    .bold()
                    .multilineTextAlignment(.center)
                    .padding(.bottom)
                Spacer()
            }
        }.frame(width: width * 0.4, height: height * 0.3, alignment: .center)
    }
}
