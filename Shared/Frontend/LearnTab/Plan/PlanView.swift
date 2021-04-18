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
    @State private var showingAnimation : Bool = false
    
    //Plan data
    @EnvironmentObject var planViewModel : PlanViewModel
    
    //View variables
    var endTitleSize : CGFloat {
        return width * 0.7
    }
    var endTitleFontSize : CGFloat {
        return width * 0.065
    }
    var tipFontSize : CGFloat {
        return width * 0.045
    }
    var endButtonHeight : CGFloat {
        return height * 0.055
    }
    let animationDuration : Double = 0.6
    let cornerRadius : CGFloat = 15
    let tipSidePadding : CGFloat = 15
    let backgroundColor : Color = Color(red: 0.96, green: 0.96, blue: 0.96) // White
    let buttonTextColor : Color = Color(red: 0.95, green: 0.32, blue: 0.34) // Red
    let textColor : Color = Color(red: 0.13, green: 0.15, blue: 0.22) // Black
    let buttonPadding : CGFloat = 20
    let width: CGFloat = UIScreen.main.bounds.width
    let height: CGFloat = UIScreen.main.bounds.height
    
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
            .default(Text("Yes")) { withAnimation{
                if(planViewModel.plan!.weekOn > 1){
                    planViewModel.moveToNextWeek(forward: false)
                }
            }},
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
            AnimatedImageView(fileName: "skateCompleteGIF") // skateboard GIF
                .frame(width: width * 0.8, height: height/2, alignment: .center)
                .cornerRadius(cornerRadius)
                .scaledToFit()
                .shadow(radius: 15)
                .opacity(showingAnimation ? 1 : 0)
            //MARK: Week Plan Display
            if(planViewModel.plan != nil){
                VStack{
                    switch(planViewModel.plan?.weekOn){
                    case 1:
                        PlanWeekView(weekNum: planViewModel.plan!.weekOn,
                                     weekDescription: "This week will be about getting used to the board by doing simply riding around to increase your confidence.",
                                     hoursPerWeek: planViewModel.plan!.hoursPerWeek)
                            .environmentObject(self.planViewModel)
                            .transition(.move(edge: .leading))
                            .animation(Animation.linear(duration: animationDuration))
                            .opacity(showingAnimation ? 0 : 1)
                    case 2:
                        PlanWeekView(weekNum: planViewModel.plan!.weekOn,
                                     weekDescription: "Now you should be semi confident on the board, the next step is to get a little more adventurous and get confident with ollies.",
                                     hoursPerWeek: planViewModel.plan!.hoursPerWeek)
                            .environmentObject(self.planViewModel)
                            .transition(.move(edge: .leading))
                            .animation(Animation.linear(duration: animationDuration))
                            .opacity(showingAnimation ? 0 : 1)
                    case 3:
                        PlanWeekView(weekNum: planViewModel.plan!.weekOn,
                                     weekDescription: "This week you will be attempting to learn two more tricks and getting more practice on the ollie.",
                                     hoursPerWeek: planViewModel.plan!.hoursPerWeek)
                            .environmentObject(self.planViewModel)
                            .transition(.move(edge: .leading))
                            .animation(Animation.linear(duration: animationDuration))
                            .opacity(showingAnimation ? 0 : 1)
                    case 4:
                        PlanWeekView(weekNum: planViewModel.plan!.weekOn,
                                     weekDescription: "At this point you should be pretty confident on the board, and so you will be trying more tricks while moving. Start off slow and as you land a few increase your speed.",
                                     hoursPerWeek: planViewModel.plan!.hoursPerWeek)
                            .environmentObject(self.planViewModel)
                            .transition(.move(edge: .leading))
                            .animation(Animation.linear(duration: animationDuration))
                            .opacity(showingAnimation ? 0 : 1)
                    case 5:
                        PlanWeekView(weekNum: planViewModel.plan!.weekOn,
                                     weekDescription: "This week is where it gets good, you will learn to flip trick over an obstacle and ollie off a curb.",
                                     hoursPerWeek: planViewModel.plan!.hoursPerWeek)
                            .environmentObject(self.planViewModel)
                            .transition(.move(edge: .leading))
                            .animation(Animation.linear(duration: animationDuration))
                            .opacity(showingAnimation ? 0 : 1)
                    case 6:
                        PlanWeekView(weekNum: planViewModel.plan!.weekOn,
                                     weekDescription: "This week you will be strengthening your flip tricks and you will learn to ollie onto a curb.",
                                     hoursPerWeek: planViewModel.plan!.hoursPerWeek)
                            .environmentObject(self.planViewModel)
                            .transition(.move(edge: .leading))
                            .animation(Animation.linear(duration: animationDuration))
                            .opacity(showingAnimation ? 0 : 1)
                    case 7:
                        PlanWeekView(weekNum: planViewModel.plan!.weekOn,
                                     weekDescription: "You are almost finished with the plan so its time to take it further, this week your going to attempt to ollie onto and grind a ledge or a rail.",
                                     hoursPerWeek: planViewModel.plan!.hoursPerWeek)
                            .environmentObject(self.planViewModel)
                            .transition(.move(edge: .leading))
                            .animation(Animation.linear(duration: animationDuration))
                            .opacity(showingAnimation ? 0 : 1)
                    case 8:
                        PlanWeekView(weekNum: planViewModel.plan!.weekOn,
                                     weekDescription: "This is your final week, at this point you can call yourself a skater and start to define your style. Just remember this is only the beginning.",
                                     hoursPerWeek: planViewModel.plan!.hoursPerWeek)
                            .environmentObject(self.planViewModel)
                            .transition(.move(edge: .leading))
                            .animation(Animation.linear(duration: animationDuration))
                            .opacity(showingAnimation ? 0 : 1)
                    default:
                        PlanEndView(rootIsActive: self.$rootIsActive)
                            .environmentObject(self.planViewModel)
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
                                .default(Text("Go to next week")) { withAnimation(.easeIn(duration: 1.5)){
                                    vibration()
                                    planViewModel.moveToNextWeek(forward: true)
                                    if(planViewModel.plan!.weekOn < 8){
                                        self.showingAnimation = true
                                    }
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                                        withAnimation(.easeOut(duration: 1.5)){
                                            self.showingAnimation = false
                                        }
                                    }
                                }},
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
    
    func vibration() {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.success)
    }
}
