//
//  PlanWeekView.swift
//  Skate App (iOS)
//
//  Created by Hubert Rzeminski on 29/01/2021.
//

import SwiftUI

struct PlanWeekView: View {
    
    // Navigation and view
    @State var weekHours : [Float]? = nil
    @EnvironmentObject var planViewModel : PlanViewModel
    var weekNum : Int
    var weekDescription : String
    var hoursPerWeek : Int
    let width : CGFloat
    let height : CGFloat

    // Set view values and list colour
    init(weekNum: Int, weekDescription: String, hoursPerWeek: Int, height: CGFloat, width: CGFloat){
        UITableView.appearance().backgroundColor = UIColor(red: 0.96, green: 0.96, blue: 0.96, alpha: 0)
        UITableViewCell.appearance().backgroundColor = UIColor(red: 0.96, green: 0.96, blue: 0.96, alpha: 0)
        UITableView.appearance().tableFooterView = UIView()
        self.weekNum = weekNum
        self.weekDescription = weekDescription
        self.hoursPerWeek = hoursPerWeek
        self.width = width
        self.height = height
    }
    
    var body: some View {
        ZStack{
            Color(red: 0.96, green: 0.96, blue: 0.96).edgesIgnoringSafeArea(.all)
            VStack{
                Text("Week: " + String(weekNum))
                    .frame(width: width, alignment: .center)
                    .font(.system(size: width * 0.07, weight: .bold, design: .monospaced))
                    .foregroundColor(Color(red: 0.13, green: 0.15, blue: 0.22))
                    .padding(.top, 40)
                    .padding(.bottom, 10)
                Text("Tip: " + weekDescription)
                    .frame(width: width * 0.85, height: height * 0.1, alignment: .center)
                    .font(.system(size: width * 0.04, weight: .bold, design: .default))
                    .foregroundColor(Color(red: 0.13, green: 0.15, blue: 0.22))
                    .padding(.bottom, 10)
                    .multilineTextAlignment(.center)
                if(planViewModel.tasks.count != 0){
                    List{
                        ForEach(planViewModel.tasks){ task in
                            if(task.weekFor == weekNum){
                                let hours = planViewModel.calculateHours(hoursPerWeek: hoursPerWeek, weekFor: weekNum, task: task)
                                Button(action: {
                                    // Update task complete
                                    planViewModel.toogleTaskComplete(docId: task.id!)
                                }){
                                    WeekPlanRowView(hours: hours, title: task.title, complete: task.complete)
                                    .padding(.bottom, 7)
                                    .padding(.top, 7)
                                }.buttonStyle(ScaleAnimationButtonEffect())
                            }
                      }
                        .listRowBackground(Color.green.opacity(0))
                    }
                }else{
                    Text("Not Loaded")
                }
            }
        }
    }
}

