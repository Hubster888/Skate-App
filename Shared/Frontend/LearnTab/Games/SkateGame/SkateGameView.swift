//
//  SkateGameView.swift
//  Skate App (iOS)
//
//  Created by Hubert Rzeminski on 15/01/2021.
//

import SwiftUI
import Firebase

struct SkateGameView: View {
    //MARK: Variable Declerations
    @State var gameType = 0 // 0 is local game and 1 is online game
    @State var showingDetail = false
    @State var showingAlert = false
    
    //@State var player1Name : String = "" // Changes depending on if the user is logged in
    let player2Name = "Player 2" // Always the same unless in online game
    
    // View variables
    var titleFontSize : CGFloat {
        return width * 0.08
    }
    var descriptionFontSize : CGFloat {
        return width * 0.04
    }
    var pickerWidth : CGFloat {
        return width * 0.9
    }
    var pickerHeight : CGFloat {
        return height * 0.05
    }
    let buttonMainColor : Color = Color(red: 0.93, green: 0.11, blue: 0.14)
    let buttonSecondColor : Color = Color(red: 0.95, green: 0.32, blue: 0.34)
    let backgroundColorWhite : Color = Color(red: 0.96, green: 0.96, blue: 0.96)
    let textColorBlack : Color = Color(red: 0.13, green: 0.15, blue: 0.22)
    let topPadding : CGFloat = 50
    let sidePadding : CGFloat = 30
    let descriptionLineSpacing : CGFloat = 8
    var height: CGFloat = UIScreen.main.bounds.height
    var width: CGFloat = UIScreen.main.bounds.width
    
    //MARK: Body
    var body: some View {
        ZStack{
            //Background view
            backgroundColorWhite.edgesIgnoringSafeArea(.all)
            
            VStack{
                // Name, description and game settings
                Text("SKATE")
                    .font(.system(size: titleFontSize, weight: .bold, design: .rounded))
                    .padding(.top, topPadding)
                    .frame(width: width, alignment: .center)
                Text("This is a classic game between two skaters. In brief one skater has to copy the trick of the other, if they fail then a letter of “SKATE” is given to them, first skater to reach the full word loses.")
                    .padding(.trailing, sidePadding)
                    .padding(.leading, sidePadding)
                    .padding(.top, topPadding)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                    .font(.system(size: descriptionFontSize, weight: .bold, design: .rounded))
                    .foregroundColor(textColorBlack)
                    .multilineTextAlignment(.center)
                    .lineLimit(nil)
                    .lineSpacing(descriptionLineSpacing)
                    .fixedSize(horizontal: false, vertical: true)
                // Game type segment picker
                Picker(selection: $gameType, label: Text("Game Type?")) {
                    Text("Local").tag(0)
                    Text("Online").tag(1)
                }
                .pickerStyle(SegmentedPickerStyle())
                .frame(width: pickerWidth, height: pickerHeight)
                .padding(.top, topPadding)
                Spacer()
                
                //MARK: Start Button
                Button(action: {
                    if(gameType == 0){ // Check if game is local or online
                        self.showingDetail.toggle() // Show the game
                    }else{
                        self.showingAlert.toggle() // Show alert that game type does not exist
                    }
                }){
                    Text("START")
                        .font(.system(.largeTitle, design: .rounded))
                        .frame(width: pickerWidth, height: pickerHeight, alignment: .center)
                }
                .sheet(isPresented: $showingDetail) {
                    StartSkateGameView(skateGame: SkateGamePlayLocal(player1: Player(name: Auth.auth().currentUser?.email ?? "Player 1"), player2: Player(name: player2Name)), isPresented: self.$showingDetail) // The game view
                }
                .alert(isPresented: $showingAlert) {
                    Alert(title: Text("Wrong mode"), message: Text("Online is not avaliable yet."), dismissButton: .default(Text("No worries"))) // Alert showing game not avaliable

                }
                .buttonStyle(GradientButtonStyle(mainColor: buttonMainColor, secondColor: buttonSecondColor))
                .padding(.bottom, sidePadding)
            }
        }
    }
}

