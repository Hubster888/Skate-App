//
//  PlanView.swift
//  Skate App (iOS)
//
//  Created by Hubert Rzeminski on 14/01/2021.
//

import SwiftUI

struct PlanView: View {
    
    // Navigation and view
    @Binding var rootIsActive : Bool
    @State private var showingActionSheet = false
    @StateObject var planViewModel : PlanViewModel
    let width : CGFloat
    let height : CGFloat
    
    // Back button definition for navigation bar
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
    
    let endTips : [String] = ["Keep riding to get more comfortable on the board.",
                              "Trick C should be practiced anywhere in between skating.",
                              "As you get more confident try tricking over, onto or off of larger obstacles.",
                              "Practice all tricks you learnt regularly to improve your consistency.",
                              "Pick out 1 or 2 tricks from the trick list at a time to learn."]
    
    var body: some View {
        ZStack{
            Color(red: 0.96, green: 0.96, blue: 0.96).edgesIgnoringSafeArea(.all)
            if(planViewModel.plan != nil){
                VStack{
                    switch(planViewModel.plan?.weekOn){
                    case 1:
                        PlanWeekView(weekNum: planViewModel.plan!.weekOn,
                                     weekDescription: "This week will be about getting used to the board by doing simply riding around to increase your confidence.",
                                     hoursPerWeek: planViewModel.plan!.hoursPerWeek, planViewModel: planViewModel, height: height, width: width)
                    case 2:
                        PlanWeekView(weekNum: planViewModel.plan!.weekOn,
                                     weekDescription: "Now you should be semi confident on the board, the next step is to get a little more adventurous and get confident with ollies.",
                                     hoursPerWeek: planViewModel.plan!.hoursPerWeek, planViewModel: planViewModel, height: height, width: width)
                    case 3:
                        PlanWeekView(weekNum: planViewModel.plan!.weekOn,
                                     weekDescription: "This week you will be attempting to learn two more tricks and getting more practice on the ollie.",
                                     hoursPerWeek: planViewModel.plan!.hoursPerWeek, planViewModel: planViewModel, height: height, width: width)
                    case 4:
                        PlanWeekView(weekNum: planViewModel.plan!.weekOn,
                                     weekDescription: "At this point you should be pretty confident on the board, and so you will be trying more tricks while moving. Start off slow and as you land a few increase your speed.",
                                     hoursPerWeek: planViewModel.plan!.hoursPerWeek, planViewModel: planViewModel, height: height, width: width)
                    case 5:
                        PlanWeekView(weekNum: planViewModel.plan!.weekOn,
                                     weekDescription: "This week is where it gets good, you will learn to flip trick over an obstacle and ollie off a curb.",
                                     hoursPerWeek: planViewModel.plan!.hoursPerWeek, planViewModel: planViewModel, height: height, width: width)
                    case 6:
                        PlanWeekView(weekNum: planViewModel.plan!.weekOn,
                                     weekDescription: "This week you will be strengthening your flip tricks and you will learn to ollie onto a curb.",
                                     hoursPerWeek: planViewModel.plan!.hoursPerWeek, planViewModel: planViewModel, height: height, width: width)
                    case 7:
                        PlanWeekView(weekNum: planViewModel.plan!.weekOn,
                                     weekDescription: "You are almost finished with the plan so its time to take it further, this week your going to attempt to ollie onto and grind a ledge or a rail.",
                                     hoursPerWeek: planViewModel.plan!.hoursPerWeek, planViewModel: planViewModel, height: height, width: width)
                    case 8:
                        PlanWeekView(weekNum: planViewModel.plan!.weekOn,
                                     weekDescription: "This is your final week, at this point you can call yourself a skater and start to define your style. Just remember this is only the beginning.",
                                     hoursPerWeek: planViewModel.plan!.hoursPerWeek, planViewModel: planViewModel, height: height, width: width)
                    default:
                        Text("Plan Finished, here is how to carry on:")
                            .frame(width: width * 0.75, alignment: .center)
                            .font(.system(size: width * 0.05, weight: .bold, design: .monospaced))
                            .foregroundColor(Color(red: 0.13, green: 0.15, blue: 0.22))
                            .multilineTextAlignment(.center)
                        /*ForEach(endTips){ tip in
                            Text(tip)
                        }*/
                        Button(action: {//end button
                            planViewModel.endPlan()
                            self.rootIsActive = false
                        }){
                            ZStack{
                                Rectangle()
                                    .fill(Color(red: 0.13, green: 0.15, blue: 0.22))
                                    .frame(width: width * 0.8, height: height * 0.05, alignment: .center)
                                    .cornerRadius(15)
                                Text("End Plan")
                                    .frame(width: width, alignment: .center)
                                    .font(.system(size: width * 0.06, weight: .bold, design: .monospaced))
                                    .foregroundColor(Color(red: 0.96, green: 0.96, blue: 0.96))
                            }
                        }.buttonStyle(ScaleAnimationButtonEffect())
                    }
                    if(planViewModel.plan!.weekOn < 9){
                        Button(action: {
                            self.showingActionSheet = true
                        }){
                            ZStack{
                                Rectangle()
                                    .fill(Color(red: 0.13, green: 0.15, blue: 0.22))
                                    .frame(width: width * 0.8, height: height * 0.05, alignment: .center)
                                    .cornerRadius(15)
                                Text("Complete Week")
                                    .frame(width: width, alignment: .center)
                                    .font(.system(size: width * 0.06, weight: .bold, design: .monospaced))
                                    .foregroundColor(Color(red: 0.96, green: 0.96, blue: 0.96))
                            }
                        }
                        .actionSheet(isPresented: $showingActionSheet) {
                            ActionSheet(title: Text("Confirm"), message: Text("Be confident with this week before moving on!"), buttons: [
                                .default(Text("Go to next week")) { planViewModel.moveToNextWeek() },
                                .cancel()
                            ])
                        }
                        .buttonStyle(ScaleAnimationButtonEffect())
                        .padding(.bottom, 20)
                        .padding(.top, 20)
                    }
                    
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
