//
//  GameListElm.swift
//  Skate App (iOS)
//
//  Created by Hubert Rzeminski on 14/01/2021.
//

import SwiftUI

struct GameListElm: View {
    let name : String
    let capabilities : String
    let width : CGFloat
    let height : CGFloat
    
    var body: some View {
        ZStack{
            Rectangle()
                .fill(Color(red: 0.13, green: 0.15, blue: 0.22, opacity: 0))
                .frame(width: width * 0.9, height: height, alignment: .center)
            HStack{
                ZStack{
                    Circle()
                        .fill(Color(red: 0.13, green: 0.15, blue: 0.22))
                        .frame(width: width * 0.2, height: height * 0.9, alignment: .center)
                        .padding(.trailing, 20)
                    Image(systemName: "play")
                        .foregroundColor(Color(red: 0.95, green: 0.32, blue: 0.34))
                        .font(.system(size: 70))
                        .padding(.trailing)
                }
                VStack{
                    Text(name)
                        .font(.system(.largeTitle, design: .rounded))
                        .foregroundColor(Color(red: 0.13, green: 0.15, blue: 0.22))
                    Text(capabilities)
                        .font(.system(.title3, design: .rounded))
                        .foregroundColor(Color(red: 0.13, green: 0.15, blue: 0.22))
                }.overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(Color(red: 0.95, green: 0.32, blue: 0.34), lineWidth: 6)
                        .frame(width: width * 0.5, height: height * 0.7, alignment: .center)
                        
                )
                .frame(width: width * 0.5, height: height * 0.7, alignment: .center)
            }
        }
    }
}

struct GameListElm_Previews: PreviewProvider {
    static var previews: some View {
        GameListElm(name: "SKATE", capabilities: "Online, Local", width: 500, height: 150)
            .previewLayout(.sizeThatFits)
    }
}
