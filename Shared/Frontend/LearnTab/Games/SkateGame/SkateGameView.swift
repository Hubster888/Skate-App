//
//  SkateGameView.swift
//  Skate App (iOS)
//
//  Created by Hubert Rzeminski on 15/01/2021.
//

import SwiftUI
import Firebase

struct SkateGameView: View {
    @State var gameType = 0
    @State var showingDetail = false
    @State var showingAlert = false
    @State var player1Name = "Player 1"
    let player2Name = "Player 2"
    
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
                Text("SKATE")
                    .font(.system(size: width * 0.06, weight: .bold, design: .rounded))
                    .padding(.top, 50)
                    .frame(width: width, alignment: .center)
                Text("This is a classic game between two skaters. In brief one skater has to copy the trick of the other, if they fail then a letter of “SKATE” is given to them, first skater to reach the full word loses.")
                    .padding(.trailing, 30)
                    .padding(.leading, 30)
                    .padding(.top, 50)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                    .font(.system(size: width * 0.04, weight: .bold, design: .rounded))
                    .foregroundColor(Color(red: 0.13, green: 0.15, blue: 0.22))
                    .multilineTextAlignment(.center)
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
                .padding(.top, height * 0.03)
                Spacer()
                
                Button(action: {
                    if(gameType != 1){
                        if(Auth.auth().currentUser != nil){
                            player1Name = "User loged 1" //Auth.auth().currentUser?.displayName get username
                            self.showingDetail.toggle()
                        }else{
                            self.showingDetail.toggle()
                        }
                    }else{
                        self.showingAlert.toggle()
                    }
                }){
                    Text("START")
                        .font(.system(.largeTitle, design: .rounded))
                        .frame(width: width * 0.8, height: height * 0.05, alignment: .center)
                }
                .sheet(isPresented: $showingDetail) {
                    StartSkateGameView(skateGame: SkateGamePlayLocal(player1: Player(name: player1Name), player2: Player(name: player2Name)), isPresented: self.$showingDetail)
                }
                .alert(isPresented: $showingAlert) {
                    Alert(title: Text("Wrong mode"), message: Text("Online is not avaliable yet."), dismissButton: .default(Text("No worries")))

                }
                .buttonStyle(GradientButtonStyle(mainColor: Color(red: 0.93, green: 0.11, blue: 0.14), secondColor: Color(red: 0.95, green: 0.32, blue: 0.34)))
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
