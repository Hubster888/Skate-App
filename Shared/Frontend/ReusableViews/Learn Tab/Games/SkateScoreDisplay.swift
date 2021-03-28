//
//  SkateScoreDisplay.swift
//  Skate App (iOS)
//
//  Created by Hubert Rzeminski on 23/02/2021.
//

import SwiftUI

struct SkateScoreDisplay: View {
    
    //MARK: Variable declerations
    //Relevant data variables
    @Binding var skateGame : SkateGamePlayLocal
    @Binding var player1LossPressed : Bool
    @Binding var player2LossPressed : Bool
    
    //View variables
    var nameFontSize : CGFloat {
        return width * 0.05
    }
    var nameWidth : CGFloat {
        width * 0.45
    }
    var namePadding : CGFloat {
        return height * 0.04
    }
    var letterFontSize : CGFloat {
        return width * 0.06
    }
    var letterWidth : CGFloat {
        return width * 0.45
    }
    var letterPadding : CGFloat {
        return height * 0.025
    }
    var vsHeight : CGFloat {
        return height * 0.6
    }
    var vsPadding : CGFloat {
        return height * 0.05
    }
    var circleDiameter : CGFloat {
        return width * 0.15
    }
    var height: CGFloat = UIScreen.main.bounds.height
    var width: CGFloat = UIScreen.main.bounds.width
    let activeColor : Color = Color(red: 0.95, green: 0.32, blue: 0.34) // Red
    let defaultColor : Color = Color(red: 66/255, green: 70/255, blue: 84/255) // Black
    let topBoxColor : Color = Color(red: 0.13, green: 0.15, blue: 0.22)
    let shadowRadius : CGFloat = 10
    let shadowDimensions : CGFloat = 5
   
    var body: some View { // FIXME: Make the game list and game look good
        HStack{ //MARK: Player 1
            VStack{
                Text(skateGame.getPlayer1().getName())
                    .font(.system(size: nameFontSize, weight: .bold, design: .rounded))
                    .underline()
                    .frame(width: nameWidth, alignment: .center)
                    .offset(x: nameFontSize)
                    .padding(.bottom, namePadding)
                Text("S")
                    .foregroundColor(skateGame.getPlayer1Score() > 0 ? activeColor : defaultColor)
                    .font(.system(size: letterFontSize, weight: .bold, design: .rounded))
                    .frame(width: letterWidth, alignment: .center)
                    .offset(x: nameFontSize)
                    .padding(.bottom, letterPadding)
                    .scaleEffect(player1LossPressed && skateGame.getPlayer1Score() == 1 ? 1.5 : 1.0)
                Text("K")
                    .foregroundColor(skateGame.getPlayer1Score() > 1 ? activeColor : defaultColor)
                    .font(.system(size: letterFontSize, weight: .bold, design: .rounded))
                    .frame(width: letterWidth, alignment: .center)
                    .offset(x: nameFontSize)
                    .padding(.bottom, letterPadding)
                    .scaleEffect(player1LossPressed && skateGame.getPlayer1Score() == 2 ? 1.5 : 1.0)
                Text("A")
                    .foregroundColor(skateGame.getPlayer1Score() > 2 ? activeColor : defaultColor)
                    .font(.system(size: letterFontSize, weight: .bold, design: .rounded))
                    .frame(width: letterWidth, alignment: .center)
                    .offset(x: nameFontSize)
                    .padding(.bottom, letterPadding)
                    .scaleEffect(player1LossPressed && skateGame.getPlayer1Score() == 3 ? 1.5 : 1.0)
                Text("T")
                    .foregroundColor(skateGame.getPlayer1Score() > 3 ? activeColor : defaultColor)
                    .font(.system(size: letterFontSize, weight: .bold, design: .rounded))
                    .frame(width: letterWidth, alignment: .center)
                    .offset(x: nameFontSize)
                    .padding(.bottom, letterPadding)
                    .scaleEffect(player1LossPressed && skateGame.getPlayer1Score() == 4 ? 1.5 : 1.0)
                Text("E")
                    .foregroundColor(skateGame.getPlayer1Score() > 4 ? activeColor : defaultColor)
                    .font(.system(size: letterFontSize, weight: .bold, design: .rounded))
                    .frame(width: letterWidth, alignment: .center)
                    .offset(x: nameFontSize)
                    .scaleEffect(player1LossPressed && skateGame.getPlayer1Score() == 5 ? 1.5 : 1.0)
            }
            
            ZStack{
                Rectangle()
                    .fill(topBoxColor)
                    .frame(width: nameFontSize, height: vsHeight, alignment: .center)
                    .padding(EdgeInsets(top: -vsPadding, leading: 0, bottom: -vsPadding, trailing: 0))
                ZStack{
                    Circle()
                        .fill(activeColor)
                        .frame(width: circleDiameter, height: circleDiameter, alignment: .center)
                        .shadow(color: defaultColor, radius: shadowRadius, x: shadowDimensions, y: shadowDimensions)
                    Text("VS")
                        .font(.system(size: letterFontSize, weight: .bold, design: .rounded))
                        .foregroundColor(defaultColor)
                }
            }
            VStack{ //MARK: Player 2
                Text(skateGame.getPlayer2().getName())
                    .font(.system(size: nameFontSize, weight: .bold, design: .rounded))
                    .underline()
                    .frame(width: letterWidth, alignment: .center)
                    .offset(x: -nameFontSize)
                    .padding(.bottom, namePadding)
                Text("S")
                    .foregroundColor(skateGame.getPlayer2Score() > 0 ? activeColor : defaultColor)
                    .font(.system(size: letterFontSize, weight: .bold, design: .rounded))
                    .frame(width: letterWidth, alignment: .center)
                    .offset(x: -nameFontSize)
                    .padding(.bottom, letterPadding)
                    .scaleEffect(player2LossPressed && skateGame.getPlayer2Score() == 1 ? 1.5 : 1.0)
                Text("K")
                    .foregroundColor(skateGame.getPlayer2Score() > 1 ? activeColor : defaultColor)
                    .font(.system(size: letterFontSize, weight: .bold, design: .rounded))
                    .frame(width: letterWidth, alignment: .center)
                    .offset(x: -nameFontSize)
                    .padding(.bottom, letterPadding)
                    .scaleEffect(player2LossPressed && skateGame.getPlayer2Score() == 2 ? 1.5 : 1.0)
                Text("A")
                    .foregroundColor(skateGame.getPlayer2Score() > 2 ? activeColor : defaultColor)
                    .font(.system(size: letterFontSize, weight: .bold, design: .rounded))
                    .frame(width: letterWidth, alignment: .center)
                    .offset(x: -nameFontSize)
                    .padding(.bottom, letterPadding)
                    .scaleEffect(player2LossPressed && skateGame.getPlayer2Score() == 3 ? 1.5 : 1.0)
                Text("T")
                    .foregroundColor(skateGame.getPlayer2Score() > 3 ? activeColor : defaultColor)
                    .font(.system(size: letterFontSize, weight: .bold, design: .rounded))
                    .frame(width: letterWidth, alignment: .center)
                    .offset(x: -nameFontSize)
                    .padding(.bottom, letterPadding)
                    .scaleEffect(player2LossPressed && skateGame.getPlayer2Score() == 4 ? 1.5 : 1.0)
                Text("E")
                    .foregroundColor(skateGame.getPlayer2Score() > 4 ? activeColor : defaultColor)
                    .font(.system(size: letterFontSize, weight: .bold, design: .rounded))
                    .frame(width: letterWidth, alignment: .center)
                    .offset(x: -nameFontSize)
                    .scaleEffect(player2LossPressed && skateGame.getPlayer2Score() == 5 ? 1.5 : 1.0)
            }
        }
    }
}
