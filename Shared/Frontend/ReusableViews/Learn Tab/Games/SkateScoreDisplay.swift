//
//  SkateScoreDisplay.swift
//  Skate App (iOS)
//
//  Created by Hubert Rzeminski on 23/02/2021.
//

import SwiftUI

struct SkateScoreDisplay: View {
    @Binding var skateGame : SkateGamePlayLocal
    var height: CGFloat = UIScreen.main.bounds.height
    var width: CGFloat = UIScreen.main.bounds.width
    @Binding var player1LossPressed : Bool
    @Binding var player2LossPressed : Bool
    
    var body: some View {
        HStack{
            VStack{
                Text(skateGame.getPlayer1().getName())
                    .font(.system(size: width * 0.05, weight: .bold, design: .rounded))
                    .underline()
                    .frame(width: width * 0.45, alignment: .center)
                    .offset(x: width * 0.05)
                    .padding(.bottom, height * 0.04)
                Text("S")
                    .foregroundColor(skateGame.getPlayer1Score() > 0 ? Color(red: 0.95, green: 0.32, blue: 0.34) : Color(red: 66/255, green: 70/255, blue: 84/255))
                    .font(.system(size: width * 0.06, weight: .bold, design: .rounded))
                    .frame(width: width * 0.45, alignment: .center)
                    .offset(x: width * 0.05)
                    .padding(.bottom, height * 0.025)
                    .scaleEffect(player1LossPressed && skateGame.getPlayer1Score() == 1 ? 1.5 : 1.0)
                Text("K")
                    .foregroundColor(skateGame.getPlayer1Score() > 1 ? Color(red: 0.95, green: 0.32, blue: 0.34) : Color(red: 66/255, green: 70/255, blue: 84/255))
                    .font(.system(size: width * 0.06, weight: .bold, design: .rounded))
                    .frame(width: width * 0.45, alignment: .center)
                    .offset(x: width * 0.05)
                    .padding(.bottom, height * 0.025)
                    .scaleEffect(player1LossPressed && skateGame.getPlayer1Score() == 2 ? 1.5 : 1.0)
                Text("A")
                    .foregroundColor(skateGame.getPlayer1Score() > 2 ? Color(red: 0.95, green: 0.32, blue: 0.34) : Color(red: 66/255, green: 70/255, blue: 84/255))
                    .font(.system(size: width * 0.06, weight: .bold, design: .rounded))
                    .frame(width: width * 0.45, alignment: .center)
                    .offset(x: width * 0.05)
                    .padding(.bottom, height * 0.025)
                    .scaleEffect(player1LossPressed && skateGame.getPlayer1Score() == 3 ? 1.5 : 1.0)
                Text("T")
                    .foregroundColor(skateGame.getPlayer1Score() > 3 ? Color(red: 0.95, green: 0.32, blue: 0.34) : Color(red: 66/255, green: 70/255, blue: 84/255))
                    .font(.system(size: width * 0.06, weight: .bold, design: .rounded))
                    .frame(width: width * 0.45, alignment: .center)
                    .offset(x: width * 0.05)
                    .padding(.bottom, height * 0.025)
                    .scaleEffect(player1LossPressed && skateGame.getPlayer1Score() == 4 ? 1.5 : 1.0)
                Text("E")
                    .foregroundColor(skateGame.getPlayer1Score() > 4 ? Color(red: 0.95, green: 0.32, blue: 0.34) : Color(red: 66/255, green: 70/255, blue: 84/255))
                    .font(.system(size: width * 0.06, weight: .bold, design: .rounded))
                    .frame(width: width * 0.45, alignment: .center)
                    .offset(x: width * 0.05)
                    .scaleEffect(player1LossPressed && skateGame.getPlayer1Score() == 5 ? 1.5 : 1.0)
            }
            
            ZStack{
                Rectangle()
                    .fill(Color(red: 0.13, green: 0.15, blue: 0.22))
                    .frame(width: width * 0.05, height: height * 0.6, alignment: .center)
                    .padding(.bottom, -height * 0.05)
                    .padding(.top, -height * 0.05)
                ZStack{
                    Circle()
                        .fill(Color(red: 0.95, green: 0.32, blue: 0.34))
                        .frame(width: width * 0.15, height: width * 0.15, alignment: .center)
                        .shadow(color: Color(red: 0.13, green: 0.15, blue: 0.22), radius: 10, x: 5, y: 5)
                    Text("VS")
                        .font(.system(size: width * 0.07, weight: .bold, design: .rounded))
                        .foregroundColor(Color(red: 0.13, green: 0.15, blue: 0.22))
                }
            }
            VStack{
                Text(skateGame.getPlayer2().getName())
                    .font(.system(size: width * 0.05, weight: .bold, design: .rounded))
                    .underline()
                    .frame(width: width * 0.45, alignment: .center)
                    .offset(x: -width * 0.05)
                    .padding(.bottom, height * 0.04)
                Text("S")
                    .foregroundColor(skateGame.getPlayer2Score() > 0 ? Color(red: 0.95, green: 0.32, blue: 0.34) : Color(red: 66/255, green: 70/255, blue: 84/255))
                    .font(.system(size: width * 0.06, weight: .bold, design: .rounded))
                    .frame(width: width * 0.45, alignment: .center)
                    .offset(x: -width * 0.05)
                    .padding(.bottom, height * 0.025)
                    .scaleEffect(player2LossPressed && skateGame.getPlayer2Score() == 1 ? 1.5 : 1.0)
                Text("K")
                    .foregroundColor(skateGame.getPlayer2Score() > 1 ? Color(red: 0.95, green: 0.32, blue: 0.34) : Color(red: 66/255, green: 70/255, blue: 84/255))
                    .font(.system(size: width * 0.06, weight: .bold, design: .rounded))
                    .frame(width: width * 0.45, alignment: .center)
                    .offset(x: -width * 0.05)
                    .padding(.bottom, height * 0.025)
                    .scaleEffect(player2LossPressed && skateGame.getPlayer2Score() == 2 ? 1.5 : 1.0)
                Text("A")
                    .foregroundColor(skateGame.getPlayer2Score() > 2 ? Color(red: 0.95, green: 0.32, blue: 0.34) : Color(red: 66/255, green: 70/255, blue: 84/255))
                    .font(.system(size: width * 0.06, weight: .bold, design: .rounded))
                    .frame(width: width * 0.45, alignment: .center)
                    .offset(x: -width * 0.05)
                    .padding(.bottom, height * 0.025)
                    .scaleEffect(player2LossPressed && skateGame.getPlayer2Score() == 3 ? 1.5 : 1.0)
                Text("T")
                    .foregroundColor(skateGame.getPlayer2Score() > 3 ? Color(red: 0.95, green: 0.32, blue: 0.34) : Color(red: 66/255, green: 70/255, blue: 84/255))
                    .font(.system(size: width * 0.06, weight: .bold, design: .rounded))
                    .frame(width: width * 0.45, alignment: .center)
                    .offset(x: -width * 0.05)
                    .padding(.bottom, height * 0.025)
                    .scaleEffect(player2LossPressed && skateGame.getPlayer2Score() == 4 ? 1.5 : 1.0)
                Text("E")
                    .foregroundColor(skateGame.getPlayer2Score() > 4 ? Color(red: 0.95, green: 0.32, blue: 0.34) : Color(red: 66/255, green: 70/255, blue: 84/255))
                    .font(.system(size: width * 0.06, weight: .bold, design: .rounded))
                    .frame(width: width * 0.45, alignment: .center)
                    .offset(x: -width * 0.05)
                    .scaleEffect(player2LossPressed && skateGame.getPlayer2Score() == 5 ? 1.5 : 1.0)
            }
        }
    }
}
