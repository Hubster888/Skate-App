//
//  PlanWeekView.swift
//  Skate App (iOS)
//
//  Created by Hubert Rzeminski on 29/01/2021.
//

import SwiftUI

struct PlanWeekView: View {
    
    var weekNum : Int
    var weeksTasks : [String]
    var weekHours : [String]
    
    var body: some View {
        VStack{
            Text("Week: " + String(weekNum))
            List(weeksTasks, id: \.self){ week in
                let index = weeksTasks.firstIndex(of: week)
                WeekPlanRowView(hours: weekHours[index ?? 0], title: week, complete: false)
            }
        }
        
        
    }
}

