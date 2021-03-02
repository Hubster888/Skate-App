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
    let cornerRadius : CGFloat = 10
    let fontColor : Color = Color(red: 0.13, green: 0.15, blue: 0.22)
    let backgroundColor : Color = Color(red: 0.96, green: 0.96, blue: 0.96) // White
    var width: CGFloat = UIScreen.main.bounds.width
    var height: CGFloat = UIScreen.main.bounds.height
    
    //MARK: Body
    var body: some View {
        ZStack{
            Rectangle()
                .fill(backgroundColor)
                .frame(width: widthOfRow, height: heightOfRow, alignment: .center)
                .cornerRadius(cornerRadius)
            HStack{
                VStack{
                    Text(trick.name)
                        .font(.system(size: nameFontSize, weight: .bold, design: .monospaced))
                        .foregroundColor(fontColor)
                        .frame(width: nameWidth, height: nameHeight, alignment: .center)
                        .padding(.leading, width * 0.075)
                        .padding(.top, height * 0.005)
                    Text(String(trickViewModel.typeToString(type: trick.type)))
                        .font(.system(size: width * 0.035, weight: .bold, design: .monospaced))
                        .foregroundColor(Color(red: 0.13, green: 0.15, blue: 0.22))
                        .frame(width: width * 0.35, height: height * 0.03, alignment: .center)
                        .padding(.leading, width * 0.075)
                        .padding(.bottom, height * 0.01)
                        .padding(.top, height * 0.005)
                }
                Spacer()
                ZStack{
                    Circle()
                        .fill(Color(red: 66/255, green: 70/255, blue: 84/255))
                        .frame(width: width * 0.12, height: width * 0.12, alignment: .trailing)
                        .padding(.trailing, width * 0.057)
                    if(trickViewModel.completionTable[trick.id!] != nil){
                        if(trickViewModel.completionTable[trick.id!]!.filter{ $0 } .count < 1){
                            
                        }else if(trickViewModel.completionTable[trick.id!]!.filter{ $0 } .count < 2){
                            Circle()
                                .trim(from: 0.75, to: showingProgress ? 0.999999 : 0.75)
                                .stroke(Color.red, lineWidth: 7)
                                .frame(width: width * 0.12, height: width * 0.12, alignment: .trailing)
                                .padding(.trailing, width * 0.057)
                                .animation(Animation.linear(duration: 0.5))
                                .onAppear(perform: {self.showingProgress = true})
                        }else if(trickViewModel.completionTable[trick.id!]!.filter{ $0 } .count < 3){
                            Circle()
                                .trim(from: 0.75, to: showingProgress ? 0.999999 : 0.75)
                                .stroke(Color.red, lineWidth: 7)
                                .frame(width: width * 0.12, height: width * 0.12, alignment: .trailing)
                                .padding(.trailing, width * 0.057)
                                .animation(Animation.linear(duration: 0.5))
                                .onAppear(perform: {self.showingProgress = true})
                            Circle()
                                .trim(from: 0.0, to: showingProgress ? 0.25 : 0.0)
                                .stroke(Color.red, lineWidth: 7)
                                .frame(width: width * 0.12, height: width * 0.12, alignment: .trailing)
                                .padding(.trailing, width * 0.057)
                                .animation(Animation.linear(duration: 0.5))
                                .onAppear(perform: {self.showingProgress = true})
                        }else if(trickViewModel.completionTable[trick.id!]!.filter{ $0 } .count < 4){
                            Circle()
                                .trim(from: 0.75, to: showingProgress ? 0.999999 : 0.75)
                                .stroke(Color.red, lineWidth: 7)
                                .frame(width: width * 0.12, height: width * 0.12, alignment: .trailing)
                                .padding(.trailing, width * 0.057)
                                .animation(Animation.linear(duration: 0.5))
                                .onAppear(perform: {self.showingProgress = true})
                            Circle()
                                .trim(from: 0.0, to: showingProgress ? 0.5 : 0.0)
                                .stroke(Color.red, lineWidth: 7)
                                .frame(width: width * 0.12, height: width * 0.12, alignment: .trailing)
                                .padding(.trailing, width * 0.057)
                                .animation(Animation.linear(duration: 0.5))
                                .onAppear(perform: {self.showingProgress = true})
                        }else{
                            Circle()
                                .trim(from: 0.0, to: showingProgress ? 0.999999 : 0.0)
                                .stroke(Color.red, lineWidth: 7)
                                .frame(width: width * 0.12, height: width * 0.12, alignment: .trailing)
                                .padding(.trailing, width * 0.057)
                                .animation(Animation.linear(duration: 0.5))
                                .onAppear(perform: {self.showingProgress = true})
                        }
                    }
                }
            }
        }
        .padding(.bottom, height * 0.025)
        .frame(width: width * 0.7, height: height * 0.1, alignment: .center)
        .onAppear{
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            }
        }
    }
}

