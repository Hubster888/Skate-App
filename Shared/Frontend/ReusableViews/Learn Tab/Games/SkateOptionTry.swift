//
//  SkateOptionTry.swift
//  Skate App (iOS)
//
//  Created by Hubert Rzeminski on 23/02/2021.
//

import SwiftUI

struct SkateOptionTry: View {
    
    //MARK: Variable declerations
    //Related data variables
    @Binding var skateGame : SkateGamePlayLocal
    @Binding var stateOfGame : StateOfGame
    @Binding var player1LossPressed : Bool
    @Binding var player2LossPressed : Bool
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
    let activeColor : Color = Color(red: 0.65, green: 0.15, blue: 0.03) // Red
    let cornerRadius : CGFloat = 15
    
    //MARK: Body
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
                        .fill(defaultColor)
                        .frame(width: buttonWidth, height: buttonHeight, alignment: .center)
                        .cornerRadius(cornerRadius)
                    Text("Nailed It!")
                        .font(.system(size: fontSize, weight: .bold, design: .rounded))
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
                        .fill(activeColor)
                        .frame(width: buttonWidth, height: buttonHeight, alignment: .center)
                        .cornerRadius(cornerRadius)
                    Text("FAILED")
                        .font(.system(size: fontSize, weight: .bold, design: .rounded))
                        .foregroundColor(Color.white)
                }
            }
            .buttonStyle(ScaleAnimationButtonEffect())
        }
    }
}
