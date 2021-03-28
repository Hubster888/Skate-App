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
    let capabilities : String
    let avaliable : Bool
    
    //View variables
    var listWidth : CGFloat {
        return width * 0.9
    }
    var listHeight : CGFloat {
        return height * 0.9
    }
    var circleWidth : CGFloat {
        return width * 0.2
    }
    var totalWidth : CGFloat {
        return width * 0.5
    }
    var totalHeight : CGFloat {
        return height * 0.7
    }
    var fontSize : CGFloat {
        return width * 0.1
    }
    let height : CGFloat = UIScreen.main.bounds.height * 0.15
    let width : CGFloat = UIScreen.main.bounds.width
    let backgroundColor : Color = Color(red: 0.13, green: 0.15, blue: 0.22, opacity: 0) // White
    let actionColor : Color = Color(red: 0.95, green: 0.32, blue: 0.34) // Red
    let fontColor : Color = Color(red: 0.13, green: 0.15, blue: 0.22) // Black
    let circlePadding : CGFloat = 20
    let cornerRadius : CGFloat = 16
    let lineWidth : CGFloat = 6
    
    //MARK: Body
    var body: some View { //FIXME: Make this look good
        ZStack{
            Rectangle()
                .fill(backgroundColor)
                .frame(width: listWidth, height: height, alignment: .center)
            HStack{
                VStack{
                    Text(name)
                        .font(.system(.largeTitle, design: .rounded))
                        .foregroundColor(fontColor.opacity(avaliable ? 1 : 0.5))
                    Text(capabilities)
                        .font(.system(.title3, design: .rounded))
                        .foregroundColor(fontColor.opacity(avaliable ? 1 : 0.5))
                }.overlay(
                    RoundedRectangle(cornerRadius: cornerRadius)
                        .stroke(actionColor.opacity(avaliable ? 1 : 0.5), lineWidth: lineWidth)
                        .frame(width: totalWidth, height: totalHeight, alignment: .center)
                        
                )
                .frame(width: totalWidth, height: totalHeight, alignment: .center)
            }
            if(!avaliable){
                Rectangle()
                    .fill(Color.gray.opacity(0.6))
                    .frame(width: listWidth, height: height, alignment: .center)
                Text("Avaliable Soon!")
                    .font(.system(size: fontSize, design: .monospaced))
                    .foregroundColor(fontColor)
            }
        }
    }
}
