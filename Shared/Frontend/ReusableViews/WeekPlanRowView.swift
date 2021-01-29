//
//  WeekPlanRowView.swift
//  Skate App (iOS)
//
//  Created by Hubert Rzeminski on 29/01/2021.
//

import SwiftUI

struct WeekPlanRowView: View {
    
    var hours : String
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
                .fill(Color.blue)
                .frame(width: width * 0.75, height: height * 0.1, alignment: .center)
            HStack{
                Text(hours)
                Rectangle()
                    .fill(Color.white)
                    .frame(width: 30, height: height * 0.1, alignment: .center)
                Text(title)
                ZStack{
                    Rectangle()
                        .fill(Color.red)
                        .frame(width: 100, height: 100, alignment: .center)
                    if complete {
                        Circle()
                            .fill(Color.green)
                            .frame(width: 90, height: 90, alignment: .center)
                    }
                }
            }
        }
    }
}

struct WeekPlanRowView_Previews: PreviewProvider {
    static var previews: some View {
        WeekPlanRowView(hours: "2", title: "Moving Pop Shove It", complete: false)
    }
}
