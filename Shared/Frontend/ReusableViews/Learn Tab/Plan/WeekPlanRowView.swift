//
//  WeekPlanRowView.swift
//  Skate App (iOS)
//
//  Created by Hubert Rzeminski on 29/01/2021.
//

import SwiftUI

struct WeekPlanRowView: View {
    
    var hours : Float
    var title : String
    var complete : Bool
    
    var width: CGFloat {
        return UIScreen.main.bounds.width
    }
    
    var height: CGFloat {
        return UIScreen.main.bounds.height
    }
    
    var body: some View {
        ZStack{
            Rectangle()
                .fill(Color(red: 0.13, green: 0.15, blue: 0.22))
                .frame(width: width * 0.9, height: height * 0.1, alignment: .center)
                .cornerRadius(10)
                .shadow(color: Color(red: 66/255, green: 70/255, blue: 84/255, opacity: 0.5), radius: 3, x: 10, y: 10)
            HStack{
                Text("\(hours < 1 ? "1/2" : String(Int(hours))) Hours")
                    .frame(width: width * 0.2, alignment: .center)
                    .font(.system(size: width * 0.04, weight: .bold, design: .monospaced))
                    .foregroundColor(Color(red: 0.96, green: 0.96, blue: 0.96))
                Rectangle()
                    .fill(Color(red: 0.96, green: 0.96, blue: 0.96))
                    .frame(width: 20, height: height * 0.1, alignment: .center)
                Text(title)
                    .frame(width: width * 0.4, alignment: .center)
                    .font(.system(size: width * 0.04, weight: .bold, design: .monospaced))
                    .foregroundColor(Color(red: 0.96, green: 0.96, blue: 0.96))
                    .multilineTextAlignment(.center)
                    .padding(.trailing, width * 0.01)
                    .padding(.leading, width * 0.01)
                ZStack{
                    Rectangle()
                        .strokeBorder(complete ? Color(red: 0.15, green: 0.72, blue: 0.08) : Color(red: 0.95, green: 0.32, blue: 0.34), lineWidth: width * 0.015)
                        .frame(width: height * 0.05, height: height * 0.05, alignment: .center)
                    if complete {
                        Circle() //Change to green tick
                            .fill(Color.green)
                            .frame(width: (height * 0.06) - 10, height: (height * 0.06) - 10, alignment: .center)
                    }
                }
            }
        }
        .frame(width: width * 0.9, height: height * 0.1, alignment: .center)
    }
}

struct WeekPlanRowView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            WeekPlanRowView(hours: 2, title: "Moving Pop Shove It", complete: false)
                
        }
    }
}
