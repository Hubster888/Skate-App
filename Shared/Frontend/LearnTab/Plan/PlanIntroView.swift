//
//  PlanIntroView.swift
//  Skate App (iOS)
//
//  Created by Hubert Rzeminski on 25/01/2021.
//

import SwiftUI
import Firebase

struct PlanIntroView: View {
    @State private var showingAlert = false
    @State private var loginDisplayed = false
    
    //MARK: Variable Declerations
    // Navigation variables
    @Binding var rootIsActive : Bool
    @State var planIsActive : Bool = false
    @State var showingLogIn = false
    
    //Plan data variables
    @EnvironmentObject var planViewModel : PlanViewModel
    @EnvironmentObject var currentUserViewModel : CurrentUserViewModel
    @State private var showingSlides : Bool = true
    @State private var questionNum : Int = 1
    private let onBoardData : [OnboardingDataModel] = [
        OnboardingDataModel(image: "PlanOnboard1", heading: "What's the plan?", text: "This here is your personalised skating plan to improve those skills in your own time. Based on a few answers you will provide; the plan plops you into the correct week and adjusts the time spent skating to your free time."),
        OnboardingDataModel(image: "PlanOnboard2", heading: "Why?", text: "Don’t know what you're doing? The plan lets you improve on your own terms and guides you through the stages of becoming a “good” skater and enjoying yourself more. \"The plan only shows recommendations, you need to go at your own pace!\""),
        OnboardingDataModel(image: "PlanOnboard3", heading: "How to?", text: "If you feel you struggled during a week, do the week over again. The whole point is to enjoy yourself. Do whatever you enjoy. Don’t be sacred to try new skills, often after a few tries of a new trick you will gain confidence even though you may have not landed it yet.")
    ]
    
    // Questions and titles
    @State private var image : String = "skatePicModed"
    @State private var buttonText : String = "Next"
    
    //Question Answers
    @State var questionAnswers : Dictionary<Int,Int> = [1:0,2:0,3:0,4:0,5:0,6:0]
    
    //View variables
    var circleWidth : CGFloat {
        return height * 0.6
    }
    var circleHeight : CGFloat {
        return height * 0.7
    }
    var circleOffsets : CGFloat {
        return height * 0.135
    }
    var imageHeight : CGFloat {
        return height * 0.3
    }
    var titleFontSize : CGFloat {
        return width * 0.055
    }
    var titleTopPadding : CGFloat {
        return height * 0.1
    }
    var titleBottomPadding : CGFloat {
        return height * 0.025
    }
    var descriptionFontSize : CGFloat {
        return width * 0.04
    }
    var buttonHeight : CGFloat {
        return height * 0.06
    }
    let shdowRadiuse : CGFloat = 3
    let cornerRadius : CGFloat = 10
    let backgroundColor : Color = Color(red: 0.96, green: 0.96, blue: 0.96) // White
    let circleColor : Color = Color(red: 0.28, green: 0.32, blue: 0.37) // Black
    let tintColor : Color = Color(red: 0.95, green: 0.32, blue: 0.34) // Red
    var width: CGFloat = UIScreen.main.bounds.width
    var height: CGFloat = UIScreen.main.bounds.height
    
    //MARK: Body
    var body: some View {
        ZStack{
            backgroundColor.edgesIgnoringSafeArea(.all)
            NavigationLink(destination: PlanView(rootIsActive: self.$rootIsActive).environmentObject(self.planViewModel), isActive: self.$planIsActive) {
                Text("")
              }.hidden() // This lets me move directly to plan view after plan creation
            if(showingSlides){ // Shows the slide show.
                OnboardingViewPure(data: onBoardData, doneFunction: {
                    if(Auth.auth().currentUser != nil){
                        self.showingSlides = false
                    }else{
                        self.showingLogIn = true
                    }
                }, backgroundColor: backgroundColor)
                .sheet(isPresented: $showingLogIn) {
                    LogInView(loginShown: self.$showingLogIn).environmentObject(self.currentUserViewModel)
                }
            }else{
                //MARK: Questionare
                if(Auth.auth().currentUser != nil){ //FIXME: Make this automaticaly update when user logs in
                    VStack{
                        switch(questionNum){
                        case 1:
                            QuestionView(questionResults: self.$questionAnswers, questionNum: self.$questionNum, question: "How many days a week are you going to skate?", answerList: ["2-3 Days","4-5 Days","6-7 Days"], twoChoice: false)
                        case 2:
                            QuestionView(questionResults: self.$questionAnswers, questionNum: self.$questionNum, question: "How many hours a day are you going to skate?", answerList: ["1 Hour","2-3 Hours","4+ Hours"], twoChoice: false)
                        case 3:
                            QuestionView(questionResults: self.$questionAnswers, questionNum: self.$questionNum, question: "How confident are you on a skateboard?", answerList: ["First time on one.","I can ride comfortably.","I try some tricks.","I was born on a board."], twoChoice: false)
                        case 4:
                            QuestionView(questionResults: self.$questionAnswers, questionNum: self.$questionNum, question: "Pick a trick that you want to learn first:", answerList: ["Pop Shove It","Kick Flip"], twoChoice: true)
                        case 5:
                            QuestionView(questionResults: self.$questionAnswers, questionNum: self.$questionNum, question: "Pick a trick that you want to learn first:", answerList: ["Casper Flip","Heel Flip"], twoChoice: true)
                        case 6:
                            QuestionView(questionResults: self.$questionAnswers, questionNum: self.$questionNum, question: "Pick a trick that you want to learn first:", answerList: ["Power Slide","Manual"], twoChoice: true)
                        default:
                            
                            //MARK: Loading And Plan Creation
                            Text("Complete!")
                                .onAppear(perform: {
                                    planViewModel.addPlanToDB(plan: planViewModel.createPlanObject(data: questionAnswers)){ res in
                                        if res {
                                            currentUserViewModel.startPlan()
                                            planViewModel.setData()
                                            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                                withAnimation {
                                                    planViewModel.fetchData()
                                                    planViewModel.fetchDataTasks()
                                                    self.rootIsActive = true
                                                }
                                            }
                                        }else{
                                            print("error")
                                            //TODO: Display alert to restart
                                        }
                                    }
                                })
                        }
                    }
                }else{
                    Text("NOT LOGGED IN").onAppear(perform: {showingSlides = true}) //TODO: Find better way to pass this message
                }
            }
        }
    }
}

