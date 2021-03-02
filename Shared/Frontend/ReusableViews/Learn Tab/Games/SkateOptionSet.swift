//
//  SkateOptionSet.swift
//  Skate App (iOS)
//
//  Created by Hubert Rzeminski on 23/02/2021.
//

import SwiftUI

struct SkateOptionSet: View {
    @Binding var skateGame : SkateGamePlayLocal
    @Binding var stateOfGame : StateOfGame
    var height: CGFloat = UIScreen.main.bounds.height
    var width: CGFloat = UIScreen.main.bounds.width
    let playerTurn : Int
    
    var body: some View {
        Button(action: {
            withAnimation{
                stateOfGame = playerTurn == 1 ? .player2Try : .player1Try
                skateGame.trickSet(player: playerTurn == 1 ? skateGame.getPlayer1() : skateGame.getPlayer2())
            }
        }){
            ZStack{
                Rectangle()
                    .fill(Color(red: 0.15, green: 0.72, blue: 0.08))
                    .frame(width: width * 0.3, height: height * 0.05, alignment: .center)
                    .cornerRadius(15)
                Text("Trick Set")
                    .font(.system(size: width * 0.05, weight: .bold, design: .rounded))
                    .foregroundColor(Color.white)
            }
        }
        .buttonStyle(ScaleAnimationButtonEffect())
    }
}

