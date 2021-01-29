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
    
    var body: some View {
        Text(question)
        List(answerList, id: \.self){answer in
            Button(action: {
                questionResults[questionNum] = answerList.firstIndex(of: answer)! + 1
                questionNum += 1
            }){
                Text(answer)
            }
        }
    }
}

