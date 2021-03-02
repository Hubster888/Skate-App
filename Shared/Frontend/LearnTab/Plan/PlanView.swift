//
//  PlanView.swift
//  Skate App (iOS)
//
//  Created by Hubert Rzeminski on 14/01/2021.
//

import SwiftUI

struct PlanView: View {
    
    //MARK: Variable Declerations
    //Navigation variables
    @Binding var rootIsActive : Bool
    @State private var showingActionSheet = false
    @State private var prevWeekAsk : Bool = false
    
    //Plan data
    @EnvironmentObject var planViewModel : PlanViewModel
    
    //View variables
    var endTitleSize : CGFloat {
        return width * 0.85
    }
    var endTitleFontSize : CGFloat {
        return width * 0.065
    }
    var tipFontSize : CGFloat {
        return width * 0.045
    }
    var endButtonHeight : CGFloat {
        return height * 0.05
    }
    let cornerRadius : CGFloat = 15
    let tipSidePadding : CGFloat = 15
    let backgroundColor : Color = Color(red: 0.96, green: 0.96, blue: 0.96) // White
    let buttonTextColor : Color = Color(red: 0.95, green: 0.32, blue: 0.34) // Red
    let textColor : Color = Color(red: 0.13, green: 0.15, blue: 0.22) // Black
    let buttonPadding : CGFloat = 20
    var width: CGFloat = UIScreen.main.bounds.width
    var height: CGFloat = UIScreen.main.bounds.height
    let endTips : [String] = ["Keep riding to get more comfortable on the board.",
                              "Trick C should be practiced anywhere in between skating.",
                              "As you get more confident try tricking over, onto or off of larger obstacles.",
                              "Practice all tricks you learnt regularly to improve your consistency.",
                              "Pick out 1 or 2 tricks from the trick list at a time to learn."]
    
    //MARK: Button Definitions
    // Back button definition for navigation bar
    var btnBack : some View { Button(action: {
        self.rootIsActive = false
    }) {
        HStack {
        Image("ic_back") //FIXME: Add a proper image with no errors
            .aspectRatio(contentMode: .fit)
            .foregroundColor(.white)
        Text("Learn")
        }
    }
    .padding(buttonPadding)
    }
    
    // Previouse week button definition for navigation bar
    var prevWeek : some View { Button(action: {
        self.prevWeekAsk = true
    }) {
        HStack {
        Image("ic_back") //FIXME: Add a proper image with no errors
            .aspectRatio(contentMode: .fit)
            .foregroundColor(.white)
        Text("Prev Week")
            .foregroundColor(buttonTextColor)
        }
    }.actionSheet(isPresented: $prevWeekAsk) {
        ActionSheet(title: Text("Confirm"), message: Text("Go back a week?"), buttons: [
            .default(Text("Yes")) { withAnimation{planViewModel.moveToNextWeek(forward: false)}},
            .cancel()
        ])
    }
    .buttonStyle(ScaleAnimationButtonEffect())
    .padding(buttonPadding)
    }
    
    //MARK: Body
    var body: some View {
        ZStack{
            backgroundColor.edgesIgnoringSafeArea(.all)
                .onAppear(perform: {
                    planViewModel.fetchDataTasks()
                })
            //MARK: Week Plan Display
            if(planViewModel.plan != nil){
                VStack{
                    switch(planViewModel.plan?.weekOn){
                    case 1:
                        PlanWeekView(weekNum: planViewModel.plan!.weekOn,
                                     weekDescription: "This week will be about getting used to the board by doing simply riding around to increase your confidence.",
                                     hoursPerWeek: planViewModel.plan!.hoursPerWeek,
                                     height: height, width: width)
                            .environmentObject(self.planViewModel)
                    case 2:
                        PlanWeekView(weekNum: planViewModel.plan!.weekOn,
                                     weekDescription: "Now you should be semi confident on the board, the next step is to get a little more adventurous and get confident with ollies.",
                                     hoursPerWeek: planViewModel.plan!.hoursPerWeek,
                                     height: height, width: width)
                            .environmentObject(self.planViewModel)
                    case 3:
                        PlanWeekView(weekNum: planViewModel.plan!.weekOn,
                                     weekDescription: "This week you will be attempting to learn two more tricks and getting more practice on the ollie.",
                                     hoursPerWeek: planViewModel.plan!.hoursPerWeek,
                                     height: height, width: width)
                            .environmentObject(self.planViewModel)
                    case 4:
                        PlanWeekView(weekNum: planViewModel.plan!.weekOn,
                                     weekDescription: "At this point you should be pretty confident on the board, and so you will be trying more tricks while moving. Start off slow and as you land a few increase your speed.",
                                     hoursPerWeek: planViewModel.plan!.hoursPerWeek,
                                     height: height, width: width)
                            .environmentObject(self.planViewModel)
                    case 5:
                        PlanWeekView(weekNum: planViewModel.plan!.weekOn,
                                     weekDescription: "This week is where it gets good, you will learn to flip trick over an obstacle and ollie off a curb.",
                                     hoursPerWeek: planViewModel.plan!.hoursPerWeek,
                                     height: height, width: width)
                            .environmentObject(self.planViewModel)
                    case 6:
                        PlanWeekView(weekNum: planViewModel.plan!.weekOn,
                                     weekDescription: "This week you will be strengthening your flip tricks and you will learn to ollie onto a curb.",
                                     hoursPerWeek: planViewModel.plan!.hoursPerWeek,
                                     height: height, width: width)
                            .environmentObject(self.planViewModel)
                    case 7:
                        PlanWeekView(weekNum: planViewModel.plan!.weekOn,
                                     weekDescription: "You are almost finished with the plan so its time to take it further, this week your going to attempt to ollie onto and grind a ledge or a rail.",
                                     hoursPerWeek: planViewModel.plan!.hoursPerWeek,
                                     height: height, width: width)
                            .environmentObject(self.planViewModel)
                    case 8:
                        PlanWeekView(weekNum: planViewModel.plan!.weekOn,
                                     weekDescription: "This is your final week, at this point you can call yourself a skater and start to define your style. Just remember this is only the beginning.",
                                     hoursPerWeek: planViewModel.plan!.hoursPerWeek,
                                     height: height, width: width)
                            .environmentObject(self.planViewModel)
                    default:
                        Spacer()
                        //MARK: End Of Plan View
                        Text("Plan Finished, here is how to carry on:") //TODO: Make end page intresting
                            .underline()
                            .frame(width: endTitleSize, alignment: .center)
                            .font(.system(size: endTitleFontSize, weight: .bold, design: .monospaced))
                            .foregroundColor(textColor)
                            .multilineTextAlignment(.center)
                        Spacer()
                        ForEach(endTips, id: \.self){ tip in
                            Text(tip)
                                .font(.system(size: tipFontSize, weight: .bold, design: .default))
                                .foregroundColor(textColor)
                                .multilineTextAlignment(.center)
                                .padding(EdgeInsets(top: 0, leading: tipSidePadding, bottom: tipSidePadding, trailing: tipSidePadding))
                        }
                        Spacer()
                        //MARK: End Button
                        Button(action: {
                            planViewModel.endPlan()
                            self.rootIsActive = false
                        }){
                            ZStack{
                                Rectangle()
                                    .fill(textColor)
                                    .frame(width: endTitleSize, height: endButtonHeight, alignment: .center)
                                    .cornerRadius(cornerRadius)
                                Text("End Plan")
                                    .frame(width: width, alignment: .center)
                                    .font(.system(size: endButtonHeight, weight: .bold, design: .monospaced))
                                    .foregroundColor(backgroundColor)
                            }
                        }.buttonStyle(ScaleAnimationButtonEffect())
                        Spacer()
                    }
                    if(planViewModel.plan!.weekOn < 9){
                        //MARK: Next Week Button
                        Button(action: {
                            self.showingActionSheet = true
                        }){
                            ZStack{
                                Rectangle()
                                    .fill(textColor)
                                    .frame(width: endTitleSize, height: endButtonHeight, alignment: .center)
                                    .cornerRadius(cornerRadius)
                                Text("Complete Week")
                                    .frame(width: width, alignment: .center)
                                    .font(.system(size: endTitleFontSize, weight: .bold, design: .monospaced))
                                    .foregroundColor(backgroundColor)
                            }
                        }
                        .actionSheet(isPresented: $showingActionSheet) { //Confirm user wants to go forward a week
                            ActionSheet(title: Text("Confirm"), message: Text("Be confident with this week before moving on!"), buttons: [
                                .default(Text("Go to next week")) { withAnimation{planViewModel.moveToNextWeek(forward: true)}},
                                .cancel()
                            ])
                        }
                        .buttonStyle(ScaleAnimationButtonEffect())
                        .padding(cornerRadius)
                    }
                }
            }else{
                Text("NOT LOADED")
            }
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: btnBack, trailing: prevWeek)
    }
}
