//
//  TrickSelectTabView.swift
//  Skate App (iOS)
//
//  Created by Hubert Rzeminski on 28/01/2021.
//

import SwiftUI

struct TrickSelectTabView: View {
    
    let tabName : String
    let tabType : [Trick]
    let width : CGFloat
    let height : CGFloat
    
    @State var showingTrick = false
    
    var body: some View {
        ZStack{
            Rectangle()
                .fill(Color(red: 66/255, green: 70/255, blue: 84/255))
            VStack{
                Text(tabName)
                    .underline()
                    .font(.system(size: 35, weight: .bold, design: .rounded))
                    .foregroundColor(Color(red: 0.96, green: 0.96, blue: 0.96))
                    .padding()
                ScrollView(.vertical){
                    VStack{
                        if(tabType.isEmpty){
                            Text("Not loaded")
                        }else{
                            ForEach(tabType){ trick in
                                let trickComplete = TrickViewModel().getTrickComplete(trick: trick)
                                Button(action: {
                                        showingTrick = true
                                }){
                                    TrickRowView(name: trick.name, trickType: trick.type, trickComplete: trickComplete, width: width, height: height).padding(.top, height * 0.0125)
                                }
                                .buttonStyle(ScaleAnimationButtonEffect())
                                .sheet(isPresented: $showingTrick) {
                                    TrickView(trickName: trick.name, trickContent: trick.description, footPlacmentDiagram: trick.placmentImg, tips: trick.tips, video: trick.video, trickHead: trick.headImg)
                                }
                            }
                        }
                    }
                    .frame(width: width * 0.8, height: height * 0.6, alignment: .top)
                }
            }
        }
        .frame(width: width * 0.8, height: height * 0.6)
        .cornerRadius(20)
        .shadow(color: Color(red: 66/255, green: 70/255, blue: 84/255, opacity: 0.5), radius: 3, x: 10, y: 10)
    }
}

