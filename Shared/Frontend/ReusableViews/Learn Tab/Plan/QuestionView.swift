//
//  QuestionView.swift
//  Skate App (iOS)
//
//  Created by Hubert Rzeminski on 29/01/2021.
//

import SwiftUI

struct QuestionView: View {
    
    //MARK: Variable declerations
    //Relevant data variables
    @Binding var questionResults : Dictionary<Int,Int>
    @Binding var questionNum : Int
    let question : String
    let answerList : [String]
    let twoChoice : Bool
    
    //View variables
    var questionSize : CGFloat {
        return width * 0.8
    }
    var questionHeight : CGFloat {
        height * 0.15
    }
    var questionFontSize : CGFloat {
        return width * 0.06
    }
    var topPadding : CGFloat {
        return height * 0.1
    }
    var answerHeight : CGFloat {
        return height * 0.06
    }
    var answerFontSize : CGFloat{
        return width * 0.04
    }
    let answerPadding : CGFloat = 7
    let questionPadding : CGFloat = 25
    let textColor : Color = Color(red: 0.13, green: 0.15, blue: 0.22) // Black
    let answerColor : Color = Color(red: 0.95, green: 0.32, blue: 0.34) // Red
    let backgroundColor : Color = Color(red: 0.96, green: 0.96, blue: 0.96) // White
    let width: CGFloat = UIScreen.main.bounds.width
    let height: CGFloat = UIScreen.main.bounds.height
    let cornerRadius : CGFloat = 15
    let shadowRadius : CGFloat = 3
    let shadowDimensions : CGFloat = 15
    
    //MARK:Body
    var body: some View {
        ZStack{
            backgroundColor.edgesIgnoringSafeArea(.all)
            VStack{
                Spacer()
                Image("Num" + questionNum.description)
                    .frame(width: width * 0.1, height: width * 0.1, alignment: .center)
                    .padding()
                Text(question)
                    .frame(width: questionSize, height: questionHeight, alignment: .center)
                    .font(.system(size: questionFontSize, weight: .bold, design: .monospaced))
                    .foregroundColor(textColor)
                    .multilineTextAlignment(.center)
                    .padding(EdgeInsets(top: 0, leading: questionPadding, bottom: 0, trailing: questionPadding))
                //Display answers
                ForEach(answerList, id: \.self){ answer in
                    Button(action: {
                        withAnimation{
                            questionResults[questionNum] = answerList.firstIndex(of: answer)! + 1
                            questionNum += 1
                        }
                    }){
                        ZStack{
                            Rectangle()
                                .fill(answerColor)
                                .frame(width: questionSize, height: answerHeight, alignment: .center)
                                .cornerRadius(cornerRadius)
                                .shadow(color: textColor.opacity(0.5), radius: shadowRadius, x: shadowDimensions, y: shadowDimensions)
                            Text(answer)
                                .font(.system(size: answerFontSize, weight: .bold, design: .default))
                                .foregroundColor(backgroundColor)
                        }.frame(alignment: .center)
                    }
                    .frame(width: questionSize, height: answerHeight, alignment: .center)
                    .buttonStyle(ScaleAnimationButtonEffect())
                    .padding(EdgeInsets(top: answerPadding, leading: 0, bottom: answerPadding, trailing: 0))
                }
                Spacer()
            }
        }
    }
}

