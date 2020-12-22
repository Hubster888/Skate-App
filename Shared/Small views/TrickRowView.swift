//
//  TrickRowView.swift
//  Skate App (iOS)
//
//  Created by Hubert Rzeminski on 21/12/2020.
//

import SwiftUI

struct TrickRowView: View {
    let name : String
    let trickType : String
    let trickComplete : [Bool]
    let width : CGFloat
    let height : CGFloat
    @State var offset = CGSize.zero
    @State var scale : CGFloat = 0.5
    
    var body: some View {
        ZStack{
            Rectangle()
                .fill(Color(red: 0.96, green: 0.96, blue: 0.96))
                .frame(width: width, height: height, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .cornerRadius(10)
            VStack{
                HStack{
                    Text(name)
                    Text("-")
                    Text(trickType)
                }
                HStack{
                    ZStack{
                        Circle()
                            .fill(Color(red: 0.95, green: 0.32, blue: 0.34, opacity: 0.7))
                            .frame(width: height * 0.5, height: height * 0.5)
                        
                        Text("R")
                            .font(.system(size: 35, weight: .bold, design: .rounded))
                            .foregroundColor(Color(red: 0.13, green: 0.15, blue: 0.22))
                    }
                    ZStack{
                        Circle()
                            .fill(Color(red: 0.95, green: 0.32, blue: 0.34, opacity: 0.7))
                            .frame(width: height * 0.5, height: height * 0.5)
                        Text("N")
                            .font(.system(.largeTitle, design: .rounded))
                            .foregroundColor(Color(red: 0.13, green: 0.15, blue: 0.22))
                    }
                    ZStack{
                        Circle()
                            .fill(Color(red: 0.95, green: 0.32, blue: 0.34, opacity: 0.7))
                            .frame(width: height * 0.5, height: height * 0.5)
                        Text("S")
                            .font(.system(.largeTitle, design: .rounded))
                            .foregroundColor(Color(red: 0.13, green: 0.15, blue: 0.22))
                    }
                    ZStack{
                        Circle()
                            .fill(Color(red: 0.95, green: 0.32, blue: 0.34, opacity: 0.7))
                            .frame(width: height * 0.5, height: height * 0.5)
                        Text("F")
                            .font(.system(.largeTitle, design: .rounded))
                            .foregroundColor(Color(red: 0.13, green: 0.15, blue: 0.22))
                    }
                }
            }
        }
        .frame(width: width, height: height, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
    }
}

struct TrickRowView_Previews: PreviewProvider {
    static var previews: some View {
        TrickRowView(name: "Trick 1", trickType: "Trick type", trickComplete: [false,false,false,false], width: 450.0, height: 150.0)
            .previewLayout(.sizeThatFits)
    }
}
