//
//  TrickRowView.swift
//  Skate App (iOS)
//
//  Created by Hubert Rzeminski on 21/12/2020.
//

import SwiftUI

struct TrickRowView: View {
    
    @EnvironmentObject private var trickViewModel : TrickViewModel
    @State private var showingProgress = false
    @State var offset = CGSize.zero
    @State var scale : CGFloat = 0.5
    @State var closed : Bool = false
    
    let trick : Trick
    let width : CGFloat
    let height : CGFloat
    
    var body: some View {
        ZStack{
            Rectangle()
                .fill(Color(red: 0.96, green: 0.96, blue: 0.96))
                .frame(width: width * 0.7, height: height * 0.1, alignment: .center)
                .cornerRadius(10)
                
            HStack{
                VStack{
                    Text(trick.name)
                        .font(.system(size: width * 0.045, weight: .bold, design: .monospaced))
                        .foregroundColor(Color(red: 0.13, green: 0.15, blue: 0.22))
                        .frame(width: width * 0.35, height: height * 0.03, alignment: .center)
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

