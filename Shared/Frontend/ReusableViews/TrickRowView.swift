//
//  TrickRowView.swift
//  Skate App (iOS)
//
//  Created by Hubert Rzeminski on 21/12/2020.
//

import SwiftUI

struct TrickRowView: View {
    let name : String
    let trickType : Int
    let trickComplete : [Bool]
    let width : CGFloat
    let height : CGFloat
    @State var offset = CGSize.zero
    @State var scale : CGFloat = 0.5
    
    var body: some View {
        ZStack{
            Rectangle()
                .fill(Color(red: 0.96, green: 0.96, blue: 0.96))
                .frame(width: width * 0.7, height: height * 0.1, alignment: .center)
            HStack{
                VStack{
                    Text(name)
                        .font(.system(size: width * 0.045, weight: .bold, design: .monospaced))
                        .foregroundColor(Color(red: 0.13, green: 0.15, blue: 0.22))
                        .frame(width: width * 0.35, height: height * 0.03, alignment: .leading)
                        .padding(.leading, width * 0.075)
                        .padding(.top, height * 0.01)
                    Text(String(trickType))
                        .font(.system(size: width * 0.035, weight: .bold, design: .monospaced))
                        .foregroundColor(Color(red: 0.13, green: 0.15, blue: 0.22))
                        .frame(width: width * 0.35, height: height * 0.03, alignment: .leading)
                        .padding(.leading, width * 0.075)
                        .padding(.bottom, height * 0.01)
                }
                Spacer()
                ZStack{
                    Circle()
                        .fill(Color(red: 66/255, green: 70/255, blue: 84/255))
                        .frame(width: width * 0.15, height: width * 0.15, alignment: .trailing)
                        .padding(.trailing, width * 0.057)
                    Arc(startAngle: .degrees(270), endAngle: .degrees(0), clockwise: false)
                        .stroke(Color.red, lineWidth: 10)
                        .frame(width: width * 0.15 , height: width * 0.015, alignment: .trailing)
                        .padding(.trailing, width * 0.057)
                }
                
            }
        }
        .frame(width: width * 0.7, height: height * 0.1, alignment: .center)
    }
    
    func typeToString(type: TrickType) -> String{
        switch type {
        case .flipTrick:
            return "Flip trick"
        case .grabTrick:
            return "Grab and air"
        case .grindTrick:
            return "Grind and slide"
        case .rampTrick:
            return "Ramp and foot plant"
        case .other:
            return "Other"
        case .none:
            return "Wrong"
        }
    }
}
