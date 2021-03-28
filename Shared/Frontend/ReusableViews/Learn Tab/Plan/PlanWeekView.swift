//
//  PlanWeekView.swift
//  Skate App (iOS)
//
//  Created by Hubert Rzeminski on 29/01/2021.
//

import SwiftUI

struct PlanWeekView: View {
    
    //MARK: Variable declerations
    //Relevant data variables
    @State var weekHours : [Float]? = nil
    @EnvironmentObject var planViewModel : PlanViewModel
    var weekNum : Int
    var weekDescription : String
    var hoursPerWeek : Int
    
    //View variables
    var fontSize : CGFloat {
        return width * 0.07
    }
    var tipWidth : CGFloat {
        return width * 0.85
    }
    var tipHeight : CGFloat {
        return height * 0.1
    }
    var tipFontSize : CGFloat {
        return width * 0.04
    }
    let width : CGFloat = UIScreen.main.bounds.width
    let height : CGFloat = UIScreen.main.bounds.height
    let UIBackgroundColor : UIColor = UIColor(red: 0.96, green: 0.96, blue: 0.96, alpha: 0) // White
    let backgroundColor : Color = Color(red: 0.96, green: 0.96, blue: 0.96) // White
    let fontColor : Color = Color(red: 0.13, green: 0.15, blue: 0.22) // Black
    let bottomPadding : CGFloat = 10
    let topPadding : CGFloat = 40
    let rowViewPadding : CGFloat = 7

    // Set view values and list colour in the initialiser
    init(weekNum: Int, weekDescription: String, hoursPerWeek: Int){
        UITableView.appearance().backgroundColor = UIBackgroundColor
        UITableViewCell.appearance().backgroundColor = UIBackgroundColor
        UITableView.appearance().tableFooterView = UIView()
        self.weekNum = weekNum
        self.weekDescription = weekDescription
        self.hoursPerWeek = hoursPerWeek
    }
    
    //MARK:Body
    var body: some View {
        ZStack{
            VStack{
                Text("Week: " + String(weekNum))
                    .frame(width: width, alignment: .center)
                    .font(.system(size: fontSize, weight: .bold, design: .monospaced))
                    .foregroundColor(fontColor)
                    .padding(EdgeInsets(top: topPadding, leading: 0, bottom: bottomPadding, trailing: 0))
                Text("Tip: " + weekDescription)
                    .frame(width: tipWidth, height: tipHeight, alignment: .center)
                    .font(.system(size: tipFontSize, weight: .bold, design: .default))
                    .foregroundColor(fontColor)
                    .padding(.bottom, bottomPadding)
                    .multilineTextAlignment(.center)
                //MARK: List
                if(planViewModel.tasks.count != 0){
                    List{
                        ForEach(planViewModel.tasks){ task in
                            if(task.weekFor == weekNum){
                                let hours = planViewModel.calculateHours(hoursPerWeek: hoursPerWeek, weekFor: weekNum, task: task)
                                WeekPlanRowView(hours: hours, task: task)
                                    .environmentObject(self.planViewModel)
                                    .padding(EdgeInsets(top: 0, leading: tipFontSize, bottom: 0, trailing: tipFontSize))
                            }
                      }
                        .listRowBackground(Color.green.opacity(0))
                    }
                }else{ //TODO: Add some error handling
                    Text("Not Loaded")
                }
            }
        }
    }
}

