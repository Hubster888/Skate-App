//
//  TrickRowView.swift
//  Skate App (iOS)
//
//  Created by Hubert Rzeminski on 21/12/2020.
//

import SwiftUI

struct TrickRowView: View {
    
    //MARK:Variable Declerations
    //Navigation variables
    @State private var showingProgress = false
    
    //Relevant data variables
    @EnvironmentObject private var trickViewModel : TrickViewModel
    let trick : Trick
    
    //View variables
    var widthOfRow : CGFloat {
        return width * 0.7
    }
    var heightOfRow : CGFloat {
        return height * 0.1
    }
    var nameFontSize : CGFloat {
        return width * 0.045
    }
    var nameWidth : CGFloat {
        return width * 0.35
    }
    var nameHeight : CGFloat {
        return height * 0.03
    }
    var typeFontSize : CGFloat {
        return width * 0.035
    }
    var circleDiam : CGFloat {
        return width * 0.12
    }
    let LINE_WIDTH : CGFloat = 7
    let CIRCLE_START : CGFloat = 0.99999999
    let CIRCLE_QUAT : CGFloat = 0.75
    let CORNER_RADIUS : CGFloat = 10
    let FONT_COLOR : Color = Color(red: 0.13, green: 0.15, blue: 0.22) // Black
    let BACKGROUND_COLOR : Color = Color(red: 0.96, green: 0.96, blue: 0.96) // White
    let LINE_COLOR : Color = Color(red: 0.95, green: 0.32, blue: 0.34)
    var width: CGFloat = UIScreen.main.bounds.width
    var height: CGFloat = UIScreen.main.bounds.height
    
    //MARK: Body
    var body: some View {
        ZStack{
            Rectangle()
                .fill(BACKGROUND_COLOR)
                .frame(width: widthOfRow, height: heightOfRow, alignment: .center)
                .cornerRadius(CORNER_RADIUS)
            HStack{
                VStack{ // Name and type
                    Text(trick.name)
                        .font(.system(size: nameFontSize, weight: .bold, design: .monospaced))
                        .foregroundColor(FONT_COLOR)
                        .frame(width: nameWidth, height: nameHeight, alignment: .center)
                        .padding(.leading, nameFontSize)
                    Text(String(trickViewModel.typeToString(type: trick.type)))
                        .font(.system(size: typeFontSize, weight: .bold, design: .monospaced))
                        .foregroundColor(FONT_COLOR)
                        .frame(width: nameWidth, height: nameHeight, alignment: .center)
                        .padding(.leading, nameFontSize)
                }
                Spacer()
                
                //MARK: Completion marker
                ZStack{
                    Circle()
                        .fill(FONT_COLOR)
                        .frame(width: circleDiam, height: circleDiam, alignment: .trailing)
                        .padding(.trailing, nameFontSize)
                    if(trickViewModel.completionTable[trick.id!] != nil){ // If trick completion has been modified
                        if(trickViewModel.completionTable[trick.id!]!.filter{ $0 } .count < 1){
                            // If none is complete, show no overlay
                        }else if(trickViewModel.completionTable[trick.id!]!.filter{ $0 } .count < 2){
                            Circle()
                                .trim(from: CIRCLE_QUAT, to: showingProgress ? CIRCLE_START : CIRCLE_QUAT)
                                .stroke(LINE_COLOR, lineWidth: LINE_WIDTH)
                                .frame(width: circleDiam, height: circleDiam, alignment: .trailing)
                                .padding(.trailing, nameFontSize)
                                .animation(Animation.linear(duration: 0.5))
                                .onAppear(perform: {self.showingProgress = true})
                        }else if(trickViewModel.completionTable[trick.id!]!.filter{ $0 } .count < 3){
                            Circle()
                                .trim(from: CIRCLE_QUAT, to: showingProgress ? CIRCLE_START : CIRCLE_QUAT)
                                .stroke(LINE_COLOR, lineWidth: LINE_WIDTH)
                                .frame(width: circleDiam, height: circleDiam, alignment: .trailing)
                                .padding(.trailing, nameFontSize)
                                .animation(Animation.linear(duration: 0.5))
                                .onAppear(perform: {self.showingProgress = true})
                            Circle()
                                .trim(from: 0.0, to: showingProgress ? 0.25 : 0.0)
                                .stroke(LINE_COLOR, lineWidth: LINE_WIDTH)
                                .frame(width: circleDiam, height: circleDiam, alignment: .trailing)
                                .padding(.trailing, nameFontSize)
                                .animation(Animation.linear(duration: 0.5))
                                .onAppear(perform: {self.showingProgress = true})
                        }else if(trickViewModel.completionTable[trick.id!]!.filter{ $0 } .count < 4){
                            Circle()
                                .trim(from: CIRCLE_QUAT, to: showingProgress ? CIRCLE_START : CIRCLE_QUAT)
                                .stroke(LINE_COLOR, lineWidth: LINE_WIDTH)
                                .frame(width: circleDiam, height: circleDiam, alignment: .trailing)
                                .padding(.trailing, nameFontSize)
                                .animation(Animation.linear(duration: 0.5))
                                .onAppear(perform: {self.showingProgress = true})
                            Circle()
                                .trim(from: 0.0, to: showingProgress ? 0.5 : 0.0)
                                .stroke(LINE_COLOR, lineWidth: LINE_WIDTH)
                                .frame(width: circleDiam, height: circleDiam, alignment: .trailing)
                                .padding(.trailing, nameFontSize)
                                .animation(Animation.linear(duration: 0.5))
                                .onAppear(perform: {self.showingProgress = true})
                        }else{
                            Circle()
                                .trim(from: 0.0, to: showingProgress ? CIRCLE_START : 0.0)
                                .stroke(LINE_COLOR, lineWidth: LINE_WIDTH)
                                .frame(width: circleDiam, height: circleDiam, alignment: .trailing)
                                .padding(.trailing, nameFontSize)
                                .animation(Animation.linear(duration: 0.5))
                                .onAppear(perform: {self.showingProgress = true})
                        }
                    }
                }
            }
        }
        .padding(.bottom, nameHeight)
        .frame(width: widthOfRow, height: heightOfRow, alignment: .center)
        .onAppear{
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            }
        }
    }
}

