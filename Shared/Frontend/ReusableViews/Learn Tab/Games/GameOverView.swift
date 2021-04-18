//
//  GameOverView.swift
//  Skate App (iOS)
//
//  Created by Hubert Rzeminski on 23/02/2021.
//

import SwiftUI
import ConfettiView

struct GameOverView: View {
    
    //MARK: Variable declerations
    //Navigation variables
    @Binding var endIsLoading : Bool
    @Binding var isPresented : Bool
    
    //Related data variables
    let skateGame : SkateGamePlayLocal
    var winner : String {
        return skateGame.getPlayer1Score() > skateGame.getPlayer2Score() ? skateGame.getPlayer2().getName() : skateGame.getPlayer1().getName()
    }
    
    //View variables
    var buttonWidth : CGFloat {
        return width * 0.8
    }
    var buttonHeight : CGFloat {
        return height * 0.08
    }
    var topRectHeight : CGFloat {
        return height * 0.4
    }
    var congratsOffset : CGFloat {
        return height * 0.125
    }
    var circleSize : CGFloat {
        return width * 0.6
    }
    var crownSize : CGFloat {
        return width * 0.35
    }
    var circleOffset : CGFloat {
        return height * 0.1
    }
    var winnerPadding : CGFloat {
        return height * 0.05
    }
    let height : CGFloat = UIScreen.main.bounds.height
    let width : CGFloat = UIScreen.main.bounds.width
    let ringColor : Color = Color.red
    let defaultColor : Color = Color(red: 66/255, green: 70/255, blue: 84/255) // Black
    let circleLineWidth : CGFloat = 7
    let cornerRadius : CGFloat = 15
    let shadowRadius : CGFloat = 10
    let bigShadowRadius : CGFloat = 25
    @State var animationOn : Bool = false
    
    //MARK: Body
    var body: some View {
        VStack{
            ZStack{
                //Top rectangle
                Rectangle()
                    .fill(ringColor)
                    .cornerRadius(cornerRadius)
                    .frame(width: width, height: topRectHeight, alignment: .top)
                    .ignoresSafeArea(.all)
                    .shadow(radius: shadowRadius)
                //"Congrats"
                Text("CONGRATS!")
                    .font(.largeTitle)
                    .foregroundColor(.white)
                    .bold()
                    .offset(y: -congratsOffset)
                ZStack{
                    //Circle
                    Circle()
                        .overlay(
                            Circle()
                                .stroke(ringColor, lineWidth: circleLineWidth)
                            ).foregroundColor(Color.white)
                        .frame(width: circleSize, height: circleSize, alignment: .center)
                    //Trophy
                    Image("crown")
                        .resizable()
                        .scaledToFit()
                        .frame(width: crownSize, height: crownSize, alignment: .center)
                        .scaleEffect(animationOn ? 1 : 0.5)
                        .animation(Animation.default.repeatCount(5))
                        .onAppear{
                            vibration()
                            withAnimation{
                                animationOn = true
                            }
                        }
                }
                .offset(y: circleOffset)
                .shadow(radius: bigShadowRadius)
            }
            Spacer()
            // "Winner is"
            Text("The Winner Is")
                .font(.title)
                .padding(.bottom, winnerPadding)
            // winner name
            Text(winner)
                .font(.largeTitle)
                .bold()
            Spacer()
            //Button
            Button(action: {
                self.isPresented = false
            }){
                ZStack{
                    Rectangle()
                        .fill(ringColor)
                        .frame(width: buttonWidth, height: buttonHeight, alignment: .center)
                        .cornerRadius(cornerRadius)
                    Text("FINISH")
                        .font(.largeTitle)
                        .bold()
                        .foregroundColor(Color.white)
                }
            }
            .buttonStyle(ScaleAnimationButtonEffect())
            Spacer()
        }
    }
    
    func vibration() {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.success)
    }
}
