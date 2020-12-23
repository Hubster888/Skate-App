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
    
    func getHeight() -> CGFloat{
        switch height {
        case 0..<80:
            return 100
        case 80..<500:
            return height
        default:
            return 0
        }
    }
    
    var body: some View {
        ZStack{
            Rectangle()
                .fill(Color(red: 0.96, green: 0.96, blue: 0.96))
                .frame(width: width * 0.9, height: getHeight(), alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .cornerRadius(10)
            VStack{
                HStack{
                    Text(name)
                        .fontWeight(.bold)
                        .font(.system(size: 20))
                        .foregroundColor(Color(red: 0.28, green: 0.32, blue: 0.37))
                    Text("-")
                        .fontWeight(.bold)
                        .font(.system(size: 20))
                        .foregroundColor(Color(red: 0.28, green: 0.32, blue: 0.37))
                    Text(trickType)
                        .fontWeight(.bold)
                        .font(.system(size: 20))
                        .foregroundColor(Color(red: 0.28, green: 0.32, blue: 0.37))
                }
                HStack{
                    TrickVariationView(variationType: "R", isComplete: trickComplete[0], diameter: width * 0.15)
                
                    TrickVariationView(variationType: "N", isComplete: trickComplete[1], diameter: width * 0.15)
                
                    TrickVariationView(variationType: "S", isComplete: trickComplete[2], diameter: width * 0.15)
                    
                    TrickVariationView(variationType: "F", isComplete: trickComplete[3], diameter: width * 0.15)
                }
            }
        }
        .frame(width: width * 0.9, height: getHeight(), alignment: .center)
    }
}

struct TrickRowView_Previews: PreviewProvider {
    static var previews: some View {
        TrickRowView(name: "Trick 1", trickType: "Trick type", trickComplete: [false,false,false,false], width: 450.0, height: 150.0)
            .previewLayout(.sizeThatFits)
    }
}
