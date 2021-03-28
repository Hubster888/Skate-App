//
//  TrickSearchView.swift
//  Skate App (iOS)
//
//  Created by Hubert Rzeminski on 19/02/2021.
//

import SwiftUI

struct TrickSearchView: View {
    
    //MARK: Variable declerations
    //Related data variables
    let name : String
    
    //View variables
    var shapeWidth : CGFloat {
        return width * 0.6
    }
    var shapeHeight : CGFloat {
        return height * 0.05
    }
    var fontSize : CGFloat {
        return width * 0.05
    }
    let width = UIScreen.main.bounds.width
    let height = UIScreen.main.bounds.height
    let shapeColor : Color = Color(red: 0.13, green: 0.15, blue: 0.22) // Black
    let textColor : Color = Color(red: 0.95, green: 0.32, blue: 0.34)
    let cornerRadius : CGFloat = 10
    
    //MARK:Body
    var body: some View { //FIXME: Make this look good
        ZStack{
            Rectangle()
                .fill(shapeColor)
                .frame(width: shapeWidth, height: shapeHeight, alignment: .center)
                .cornerRadius(cornerRadius)
            Text(name)
                .font(.system(size: fontSize, weight: .bold, design: .monospaced))
                .foregroundColor(textColor)
        }
    }
}
