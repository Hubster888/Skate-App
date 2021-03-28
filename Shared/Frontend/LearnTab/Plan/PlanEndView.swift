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
    var endTitleSize : CGFloat {
        return width * 0.85
    }
    var endTitleFontSize : CGFloat {
        return width * 0.065
    }
    var tipFontSize : CGFloat {
        return width * 0.04
    }
    var circleDiameter: CGFloat {
        return width * 0.45
    }
    var gifPadding : CGFloat {
        return height * 0.025
    }
    var gifHeight : CGFloat {
        return height * 0.25
    }
    let tipShadowDimensions : CGFloat = 5
    let shadowRadius : CGFloat = 10
    let width: CGFloat = UIScreen.main.bounds.width
    let height: CGFloat = UIScreen.main.bounds.height
    let textColor : Color = Color(red: 0.13, green: 0.15, blue: 0.22) // Black
    let backgroundColor : Color = Color(red: 0.96, green: 0.96, blue: 0.96) // White
    
    //MARK: Body
    var body: some View {
        ZStack{
            backgroundColor.edgesIgnoringSafeArea(.all)
            VStack{
                Spacer()
                Text("Plan Finished!") // Title
                    .frame(width: endTitleSize, alignment: .center)
                    .font(.system(size: endTitleFontSize, weight: .bold, design: .monospaced))
                    .foregroundColor(textColor)
                    .padding(.bottom, gifPadding)
                    .padding(.top, gifPadding)
                AnimatedImageView(fileName: "PlanEndGIF") // Celebration GIF
                    .frame(width: endTitleSize, height: gifHeight, alignment: .top)
                    .padding(.bottom, gifPadding)
                    .shadow(color: textColor, radius: shadowRadius, x: tipShadowDimensions, y: tipShadowDimensions)
                    .cornerRadius(shadowRadius)
                Spacer()
                // The tip slides
                OnboardingViewPure(data: onBoardData, doneFunction: { // On end button press
                    planViewModel.endPlan()
                    rootIsActive = false
                    }, backgroundColor: backgroundColor)
                .frame(width: width, height: gifHeight, alignment: .center)
                Spacer()
            }
        }
    }
}
