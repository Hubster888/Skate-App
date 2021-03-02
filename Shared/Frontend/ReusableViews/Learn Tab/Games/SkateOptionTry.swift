//
//  SkateOptionTry.swift
//  Skate App (iOS)
//
//  Created by Hubert Rzeminski on 23/02/2021.
//

import SwiftUI

struct SkateOptionTry: View {
    @Binding var skateGame : SkateGamePlayLocal
    @Binding var stateOfGame : StateOfGame
    var height: CGFloat = UIScreen.main.bounds.height
    var width: CGFloat = UIScreen.main.bounds.width
    @Binding var player1LossPressed : Bool
    @Binding var player2LossPressed : Bool
    let playerTurn : Int
    
    var body: some View {
        HStack{
            Button(action: {
                withAnimation{
                    stateOfGame = playerTurn == 1 ? .player1Set : .player2Set
                    skateGame.trickNailed(player: playerTurn == 1 ? skateGame.getPlayer1() : skateGame.getPlayer2())
                }
            }){
                ZStack{
                    Rectangle()
                        .fill(Color(red: 0.15, green: 0.72, blue: 0.08))
                        .frame(width: width * 0.3, height: height * 0.05, alignment: .center)
                        .cornerRadius(15)
                    Text("Nailed It!")
                        .font(.system(size: width * 0.05, weight: .bold, design: .rounded))
                        .foregroundColor(Color.white)
                }
            }
            .buttonStyle(ScaleAnimationButtonEffect())
            
            Button(action: {
                withAnimation{
                    stateOfGame = playerTurn == 1 ? .player2Set : .player1Set
                    skateGame.trickFailed(player: playerTurn == 1 ? skateGame.getPlayer1() : skateGame.getPlayer2())
                    player1LossPressed = true
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        withAnimation {
                            player1LossPressed = false
                        }
                    }
                }
            }){
                ZStack{
                    Rectangle()
                        .fill(Color(red: 0.65, green: 0.15, blue: 0.03))
                        .frame(width: width * 0.3, height: height * 0.05, alignment: .center)
                        .cornerRadius(15)
                    Text("FAILED")
                        .font(.system(size: width * 0.05, weight: .bold, design: .rounded))
                        .foregroundColor(Color.white)
                }
            }
            .buttonStyle(ScaleAnimationButtonEffect())
        }
    }
}
