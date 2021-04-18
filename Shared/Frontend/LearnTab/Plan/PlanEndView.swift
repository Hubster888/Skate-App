//
//  PlanEndView.swift
//  Skate App (iOS)
//
//  Created by Hubert Rzeminski on 18/03/2021.
//

import SwiftUI

struct PlanEndView: View {
    
    //MARK: Variable declerations
    // Related data variables
    @EnvironmentObject var planViewModel : PlanViewModel
    @State var tipNum: Int = 0
    var onBoardData : [OnboardingDataModel] = [
        OnboardingDataModel(image: nil, heading: "One with the board", text: "Keep riding to get more comfortable on the board."),
        OnboardingDataModel(image: nil, heading: "Practice is king", text: "Don't forget to practice tricks you've already learnt."),
        OnboardingDataModel(image: nil, heading: "Bigger, stronger, faster", text: "As you get more confident try tricking over, onto or off of larger obstacles."),
        OnboardingDataModel(image: nil, heading: "Keep it simple", text: "Pick out 1 or 2 tricks from the trick list at a time to learn."),
    ]
    
    // Navigation variables
    @State private var onboardinDone = false
    @Binding var rootIsActive : Bool
    
    // View variables
    var slideHeight : CGFloat {
        return height * 0.25
    }
    var topHeight : CGFloat {
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
    var bottomPadding : CGFloat {
        return height * 0.01
    }
    let cornerRadius : CGFloat = 15
    let shadowRadius : CGFloat = 10
    let bigShadowRadius : CGFloat = 25
    let ringWidth : CGFloat = 7
    let width: CGFloat = UIScreen.main.bounds.width
    let height: CGFloat = UIScreen.main.bounds.height
    let ringColor : Color = Color.red // Red
    let textColor : Color = Color(red: 0.13, green: 0.15, blue: 0.22) // Black
    let backgroundColor : Color = Color(red: 0.96, green: 0.96, blue: 0.96) // White
    @State var animationOn : Bool = false
    
    //MARK: Body
    var body: some View {
        VStack{
            ZStack{
                //Top rectangle
                Rectangle()
                    .fill(ringColor)
                    .cornerRadius(cornerRadius)
                    .frame(width: width, height: topHeight, alignment: .top)
                    .ignoresSafeArea(.all)
                    .shadow(radius: shadowRadius)
                //"Congrats"
                Text("You Did It!")
                    .font(.largeTitle)
                    .foregroundColor(backgroundColor)
                    .bold()
                    .offset(y: -congratsOffset)
                ZStack{
                    //Circle
                    Circle()
                        .overlay(
                            Circle()
                                .stroke(ringColor, lineWidth: ringWidth)
                            ).foregroundColor(backgroundColor)
                        .frame(width: circleSize, height: circleSize, alignment: .center)
                    //Trophy
                    Image("crown")
                        .resizable()
                        .scaledToFit()
                        .frame(width: crownSize, height: crownSize, alignment: .center)
                        .scaleEffect(animationOn ? 1 : 0.5)
                        .animation(Animation.default.repeatCount(5))
                        .onAppear{
                            withAnimation{
                                animationOn = true
                            }
                        }
                }
                .offset(y: circleOffset)
                .shadow(radius: bigShadowRadius)
            }
            Spacer()
            OnboardingViewPure(data: onBoardData, doneFunction: { // On end button press
                planViewModel.endPlan()
                rootIsActive = false
                }, backgroundColor: backgroundColor)
            .frame(width: width, height: slideHeight, alignment: .center)
            .padding(.top, circleOffset)
            .padding(.bottom, bottomPadding)
        }
    }
}
