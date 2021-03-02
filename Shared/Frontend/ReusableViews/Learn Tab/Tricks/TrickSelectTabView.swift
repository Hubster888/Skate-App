//
//  TrickSelectTabView.swift
//  Skate App (iOS)
//
//  Created by Hubert Rzeminski on 28/01/2021.
//

import SwiftUI

struct TrickSelectTabView: View {
    @EnvironmentObject private var trickViewModel : TrickViewModel
    let tabDiff : Int
    let width : CGFloat
    let height : CGFloat
    let segment : Int
    @Binding var isEditing : Bool
    @State var tabName : String? = nil
    
    var body: some View {
        ZStack{
            Rectangle()
                .fill(Color(red: 66/255, green: 70/255, blue: 84/255).opacity(isEditing ? 0.5 : 1))
            VStack{
                Text(tabName ?? "NO NAME")
                    .underline()
                    .font(.system(size: 35, weight: .bold, design: .rounded))
                    .foregroundColor(Color(red: 0.96, green: 0.96, blue: 0.96))
                    .padding()
                ScrollView(.vertical){
                    VStack{
                        TrickListView(tabDiff: tabDiff, segment: self.segment).environmentObject(self.trickViewModel).opacity(isEditing ? 0.5 : 1)
                    }
                    .frame(width: width * 0.8, height: height * 0.6, alignment: .top)
                }
            }
        }
        .frame(width: width * 0.8, height: height * 0.6)
        .cornerRadius(20)
        .shadow(color: Color(red: 66/255, green: 70/255, blue: 84/255, opacity: 0.5), radius: 3, x: 10, y: 10)
        .onAppear(perform: {
            switch tabDiff{
            case 1:
                self.tabName = "Beginner"
            case 2:
                self.tabName = "Intermidiate"
            case 3:
                self.tabName = "Pro"
            case 4:
                self.tabName = "God Like"
            default:
                self.tabName = "Nothing"
            }
        })
    }
}

