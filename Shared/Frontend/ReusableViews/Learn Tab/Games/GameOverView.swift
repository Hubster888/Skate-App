//
//  GameOverView.swift
//  Skate App (iOS)
//
//  Created by Hubert Rzeminski on 23/02/2021.
//

import SwiftUI

struct GameOverView: View {
    let height : CGFloat = UIScreen.main.bounds.height
    let width : CGFloat = UIScreen.main.bounds.width
    @Binding var endIsLoading : Bool
    @Binding var isPresented : Bool
    let skateGame : SkateGamePlayLocal
    var body: some View {
        ZStack{
            Color.green.edgesIgnoringSafeArea(.all)
            VStack{
                Spacer()
                ZStack{
                    Circle()
                        .stroke(Color(red: 66/255, green: 70/255, blue: 84/255), lineWidth: width * 0.05)
                        .frame(width: width * 0.5, height: width * 0.5)

                    Circle()
                        .trim(from: 0, to: 0.2)
                        .stroke(Color(red: 0.95, green: 0.32, blue: 0.34), lineWidth: 7)
                        .frame(width: width * 0.5, height: width * 0.5)
                        .rotationEffect(Angle(degrees: endIsLoading ? 360 : 0))
                        .animation(Animation.linear(duration: 2).repeatForever(autoreverses: false))
                        .onAppear(perform: {self.endIsLoading = true})
                    
                    Circle()
                        .stroke(Color(red: 66/255, green: 70/255, blue: 84/255), lineWidth: width * 0.05)
                        .frame(width: width * 0.6, height: width * 0.6)

                    Circle()
                        .trim(from: 0, to: 0.2)
                        .stroke(Color(red: 0.95, green: 0.32, blue: 0.34), lineWidth: 7)
                        .frame(width: width * 0.6, height: width * 0.6)
                        .rotationEffect(Angle(degrees: endIsLoading ? 0 : 360))
                        .animation(Animation.linear(duration: 2).repeatForever(autoreverses: false))
                        .onAppear(perform: {self.endIsLoading = true})
                    
                    Text(skateGame.getPlayer1Score() > skateGame.getPlayer2Score() ? "The winner is \n" + skateGame.getPlayer2().getName() : "The winner is \n" + skateGame.getPlayer1().getName())
                        .font(.system(size: width * 0.05, weight: .bold, design: .rounded))
                        .multilineTextAlignment(.center)
                }.padding(.bottom, height * 0.1)
                
                Button(action: {
                    self.isPresented = false
                }){
                    ZStack{
                        Rectangle()
                            .fill(Color(red: 0.13, green: 0.15, blue: 0.22))
                            .frame(width: width * 0.8, height: height * 0.08, alignment: .center)
                            .cornerRadius(15)
                        Text("FINISH")
                            .font(.system(size: width * 0.08, weight: .bold, design: .rounded))
                            .foregroundColor(Color.white)
                    }
                }
                .buttonStyle(ScaleAnimationButtonEffect())
                
                Spacer()
            }
        }
    }
}

