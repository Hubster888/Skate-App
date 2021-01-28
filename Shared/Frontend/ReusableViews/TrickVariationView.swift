//
//  TrickVariationView.swift
//  Skate App (iOS)
//
//  Created by Hubert Rzeminski on 22/12/2020.
//

import SwiftUI

struct TrickVariationView: View {
    let variationType : String
    let isComplete : Bool
    let diameter : CGFloat

    func pickFontSize() -> CGFloat {
        switch diameter {
            case 0:
                return 0
            case 0..<30:
                return 10
            case 30..<40:
                return 20
            case 40..<50:
                return 20
            case 50..<60:
                return 30
            case 60..<70:
                return 40
            default:
                return 0
        }
    }
    
    
    var body: some View {
        ZStack{
            if(isComplete){
                Circle()
                    .fill(Color(red: 0.95, green: 0.32, blue: 0.34))
                    .frame(width: diameter, height: diameter, alignment: .center)
            }else{
                Circle()
                    .fill(Color(red: 0.95, green: 0.32, blue: 0.34, opacity: 0.75))
                    .frame(width: diameter, height: diameter, alignment: .center)
            }
            Text(variationType)
                .fontWeight(.bold)
                .font(.system(size: pickFontSize()))
                .foregroundColor(Color(red: 0.28, green: 0.32, blue: 0.37))
        }
    }
}

struct TrickVariationView_Previews: PreviewProvider {
    static var previews: some View {
        TrickVariationView(variationType: "R", isComplete: true, diameter: 42.8)
            .previewLayout(.sizeThatFits)
    }
}

//For trick view the diam on big device is 42.8, on small it is 37.5
// For list view on big device it is 50.076, on small it is 43.875


