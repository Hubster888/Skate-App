//
//  CheckBox.swift
//  Skate App (iOS)
//
//  Created by Hubert Rzeminski on 14/03/2021.
//

import SwiftUI

struct CheckBox: View {
    //MARK: Variable declerations
    //Relevant data variables
    @Binding var checked : Bool
    @Binding var trimVal : CGFloat
    
    //View variables
    var animatableData : CGFloat {
        get {trimVal}
        set {trimVal = newValue}
    }
    var bigBoxWidth : CGFloat {
        return width * 0.1
    }
    var smallBoxWidth : CGFloat {
        return bigBoxWidth - 10
    }
    let width : CGFloat = UIScreen.main.bounds.width
    let height : CGFloat = UIScreen.main.bounds.height
    let cornerRadius : CGFloat = 10
    let lineWidth : CGFloat = 4
    
    //MARK: Body
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: cornerRadius)
                .trim(from: 0, to: trimVal)
                .stroke(style: StrokeStyle(lineWidth: lineWidth))
                .frame(width: bigBoxWidth, height: bigBoxWidth)
                .foregroundColor(checked ? Color.green : Color.red.opacity(0.2))
            RoundedRectangle(cornerRadius: cornerRadius)
                .trim(from: 0, to: 1)
                .stroke(style: StrokeStyle(lineWidth: lineWidth))
                .frame(width: smallBoxWidth, height: smallBoxWidth)
                .foregroundColor(checked ? Color.green : Color.red.opacity(0.2))
            if(checked){
                Image(systemName: "checkmark")
                    .foregroundColor(Color.white)
            }
        }
        
        
    }
}

