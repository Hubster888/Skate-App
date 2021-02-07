//
//  QuestionView.swift
//  Skate App (iOS)
//
//  Created by Hubert Rzeminski on 29/01/2021.
//

import SwiftUI

struct QuestionView: View {
    
    @Binding var questionResults : Dictionary<Int,Int>
    @Binding var questionNum : Int
    let question : String
    let answerList : [String]
    let twoChoice : Bool
    
    var width: CGFloat {
        return UIScreen.main.bounds.width
    }
    
    var height: CGFloat {
        return UIScreen.main.bounds.height
    }
    
    var body: some View {
        VStack{
            Text(question)
                .frame(width: width * 0.8, height: height * 0.15, alignment: .center)
                .font(.system(size: width * 0.06, weight: .bold, design: .monospaced))
                .foregroundColor(Color(red: 0.13, green: 0.15, blue: 0.22))
                .multilineTextAlignment(.center)
                .padding(.top, height * 0.1)
                .padding(.leading, 25)
                .padding(.trailing, 25)
            ForEach(answerList, id: \.self){ answer in
                Button(action: {
                    withAnimation{
                        questionResults[questionNum] = answerList.firstIndex(of: answer)! + 1
                        questionNum += 1
                    }
                }){
                    ZStack{
                        Rectangle()
                            .fill(Color(red: 0.95, green: 0.32, blue: 0.34))
                            .frame(width: width * 0.7, height: height * 0.06, alignment: .center)
                            .cornerRadius(15)
                            .shadow(color: Color(red: 66/255, green: 70/255, blue: 84/255, opacity: 0.5), radius: 3, x: 10, y: 10)
                        Text(answer)
                            .font(.system(size: width * 0.04, weight: .bold, design: .default))
                            .foregroundColor(Color(red: 0.96, green: 0.96, blue: 0.96))
                    }.frame(alignment: .center)
                }
                .frame(width: width * 0.7, height: height * 0.06, alignment: .center)
                .buttonStyle(ScaleAnimationButtonEffect())
                .padding(.top, 7)
                .padding(.bottom, 7)
            }.listRowBackground(Color.green.opacity(0))
            Spacer()
        }
    }
}

