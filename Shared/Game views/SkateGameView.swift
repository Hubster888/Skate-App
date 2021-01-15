//
//  SkateGameView.swift
//  Skate App (iOS)
//
//  Created by Hubert Rzeminski on 15/01/2021.
//

import SwiftUI

struct SkateGameView: View {
    @State var gameType = 0
    @State var gameMode = 0
    @State var showingDetail = false
    
    var height: CGFloat {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return UIScreen.main.bounds.height
        } else {
            return UIScreen.main.bounds.height
        }
    }
    
    var width: CGFloat {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return UIScreen.main.bounds.width
        } else {
            return UIScreen.main.bounds.width
        }
    }
    
    var body: some View {
        ZStack{
            Color(red: 0.96, green: 0.96, blue: 0.96).edgesIgnoringSafeArea(.all)
            VStack{
                Text("This is a classic game between two skaters. In brief one skater has to copy the trick of the other, if they fail then a letter of “SKATE” is given to them, first skater to reach the full word loses.")
                    .padding(.trailing, 20)
                    .padding(.leading, 20)
                    .padding(.top, 30)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                    .font(.system( .body, design: .rounded))
                    .foregroundColor(Color(red: 0.13, green: 0.15, blue: 0.22))
                    .multilineTextAlignment(.leading)
                    .lineLimit(nil)
                    .lineSpacing(8)
                    .fixedSize(horizontal: false, vertical: true)
                
                Picker(selection: $gameType, label: Text("Game Type?")) {
                    Text("Local").tag(0)
                    Text("Online").tag(1)
                }
                .pickerStyle(SegmentedPickerStyle())
                .frame(width: width * 0.9, height: height * 0.05)
                .padding(.bottom, height * 0.01)
                .padding(.top, height * 0.01)
                
       
                Picker(selection: $gameMode, label: Text("Completed trick?")) {
                    Text("Flat ground").tag(0)
                    Text("Grinds and slides").tag(1)
                    Text("Any").tag(2)
                }
                .pickerStyle(SegmentedPickerStyle())
                .frame(width: width * 0.9, height: height * 0.05)
                .padding(.bottom, height * 0.01)
                .padding(.top, height * 0.01)
                Spacer()
                
                Button(action: {self.showingDetail.toggle()}){
                    Text("START")
                        .font(.system(.largeTitle, design: .rounded))
                        .frame(width: width * 0.8, height: height * 0.05, alignment: .center)
                }
                .sheet(isPresented: $showingDetail) {
                    StartSkateGameView(isPresented: self.$showingDetail)
                }
                .buttonStyle(GradientButtonStyle())
                .padding(.bottom, 20)
            }
        }
    }
}

struct SkateGameView_Previews: PreviewProvider {
    static var previews: some View {
        SkateGameView()
    }
}
