//
//  TrickSelectTabView.swift
//  Skate App (iOS)
//
//  Created by Hubert Rzeminski on 28/01/2021.
//

import SwiftUI

struct TrickSelectTabView: View {
    
    //MARK: Variable declerations
    //Navigation variables
    @Binding var isEditing : Bool
    
    //Relevant data variables
    @EnvironmentObject private var trickViewModel : TrickViewModel
    let tabDiff : Int
    let segment : Int
    @State var tabName : String? = nil
    
    //View variables
    var fontSize : CGFloat {
        return width * 0.08
    }
    var scrollWidth : CGFloat {
        return width * 0.8
    }
    var scrollHeight : CGFloat {
        return height * 0.6
    }
    let textColor : Color = Color(red: 0.96, green: 0.96, blue: 0.96) // White
    let backgroundColor : Color = Color(red: 66/255, green: 70/255, blue: 84/255) // Black
    let cornerRadius : CGFloat = 20
    let shadowRadius : CGFloat = 5
    let shadowDimensions : CGFloat = 10
    var width: CGFloat = UIScreen.main.bounds.width
    var height: CGFloat = UIScreen.main.bounds.height
    
    //MARK: Body
    var body: some View {
        ZStack{
            Rectangle()
                .fill(backgroundColor.opacity(isEditing ? 0.5 : 1))
            VStack{
                Text(tabName ?? "NO NAME")
                    .underline()
                    .font(.system(size: fontSize, weight: .bold, design: .monospaced))
                    .foregroundColor(textColor)
                    .padding()
                //MARK: Scroll View
                ScrollView(.vertical){
                    VStack{
                        TrickListView(tabDiff: tabDiff, segment: self.segment).environmentObject(self.trickViewModel).opacity(isEditing ? 0.5 : 1)
                    }
                    .frame(width: scrollWidth, height: scrollHeight, alignment: .top)
                }
            }
        }
        .frame(width: scrollWidth, height: scrollHeight)
        .cornerRadius(cornerRadius)
        .shadow(color: .black, radius: shadowRadius, x: shadowDimensions, y: shadowDimensions)
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

