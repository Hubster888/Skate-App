//
//  TrickSearchView.swift
//  Skate App (iOS)
//
//  Created by Hubert Rzeminski on 19/02/2021.
//

import SwiftUI

struct TrickSearchView: View {
    
    let name : String
    let width : CGFloat
    let height : CGFloat
    
    var body: some View {
        ZStack{
            Rectangle()
                .fill(Color(red: 0.13, green: 0.15, blue: 0.22))
                .frame(width: width * 0.6, height: height * 0.05, alignment: .center)
                .cornerRadius(10)
            Text(name)
                .font(.system(size: width * 0.05, weight: .bold, design: .monospaced))
                .foregroundColor(Color(red: 0.95, green: 0.32, blue: 0.34))
        }
    }
}
