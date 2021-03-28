//
//  SkateOptionSet.swift
//  Skate App (iOS)
//
//  Created by Hubert Rzeminski on 23/02/2021.
//

import SwiftUI

struct SkateOptionSet: View {
    
    //MARK: Variable declerations
    //Related data variables
    @Binding var skateGame : SkateGamePlayLocal
    @Binding var stateOfGame : StateOfGame
    let playerTurn : Int
    
    //View variables
    var buttonWidth : CGFloat {
        return width * 0.3
    }
    var buttonHeight : CGFloat {
        return height * 0.05
    }
    var fontSize : CGFloat {
        return width * 0.05
    }
    let height: CGFloat = UIScreen.main.bounds.height
    let width: CGFloat = UIScreen.main.bounds.width
    let defaultColor : Color = Color(red: 0.15, green: 0.72, blue: 0.08) // Black
    let cornerRadius : CGFloat = 15
    
    //MARK: Body
    var body: some View {
        Button(action: {
            withAnimation{
                stateOfGame = playerTurn == 1 ? .player2Try : .player1Try
                skateGame.trickSet(player: playerTurn == 1 ? skateGame.getPlayer1() : skateGame.getPlayer2())
            }
        }){
            ZStack{
                Rectangle()
                    .fill(defaultColor)
                    .frame(width: buttonWidth, height: buttonHeight, alignment: .center)
                    .cornerRadius(cornerRadius)
                Text("Trick Set")
                    .font(.system(size: fontSize, weight: .bold, design: .rounded))
                    .foregroundColor(Color.white)
            }
        }
        .buttonStyle(ScaleAnimationButtonEffect())
    }
}

