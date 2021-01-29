//
//  PlanView.swift
//  Skate App (iOS)
//
//  Created by Hubert Rzeminski on 14/01/2021.
//

import SwiftUI

struct PlanView: View {
    @Binding var rootIsActive : Bool
    @ObservedObject private var planViewModel = PlanViewModel()
    
    var btnBack : some View { Button(action: {
            self.rootIsActive = false
            }) {
                HStack {
                Image("ic_back") // set image here
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(.white)
                    Text("Go back")
                }
            }
        }
    
    var body: some View {
        ZStack{
            Color(red: 0.96, green: 0.96, blue: 0.96).edgesIgnoringSafeArea(.all)
            if(planViewModel.plan != nil){
                switch(planViewModel.plan?.weekOn){
                case 1:
                    PlanWeekView(weekNum: planViewModel.plan!.weekOn, weeksTasks: ["Pop Shove It", "Riding around"], weekHours: ["1 hour", "2 hours"])
                case 2:
                    PlanWeekView(weekNum: planViewModel.plan!.weekOn, weeksTasks: ["Heel flip", "Riding Jump", "Ollie"], weekHours: ["1/2 hour", "4 hours", "1 hour"])
                default:
                    Text("differentWeek")
                }
                Button(action: {
                    // planViewModel.moveToNextWeek()
                }){
                    Text("Complete Week")
                }
            }else{
                Text("NOT LOADED")
            }
        }.onAppear(perform: {
            planViewModel.fetchData()
        })
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: btnBack)
            
    }

}
