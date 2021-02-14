//
//  PlanIntroView.swift
//  Skate App (iOS)
//
//  Created by Hubert Rzeminski on 25/01/2021.
//

import SwiftUI
import Firebase

//let newUpdate = UpdatePlanDB()

struct PlanIntroView: View {
    
    // Navigation and view
    @Binding var rootIsActive : Bool
    @State var planIsActive : Bool = false
    @State var showingLogIn = false
    @State private var introSlide : Int = 0
    @State private var questionNum : Int = 1
    @EnvironmentObject var planViewModel : PlanViewModel
    @EnvironmentObject var currentUserViewModel : CurrentUserViewModel
    let width : CGFloat
    let height : CGFloat
    
    //Question Answers
    @State var questionAnswers : Dictionary<Int,Int> = [1:0,2:0,3:0,4:0,5:0,6:0]
    
    // Questions and titles
    @State private var image : String = "skatePicModed"
    @State private var title : String = "Title"
    private let description1 : String = "This here is your personalised skating plan to improve those skills in your own time. Based on a few answers you will provide; the plan plops you into the correct week and adjusts the time spent skating to your free time."
    private let description2 : String = "Don’t know what you're doing? The plan lets you improve on your own terms and guides you through the stages of becoming a “good” skater and enjoying yourself more. \"The plan only shows recommendations, you need to go at your own pace!\""
    private let description3 : String = "If you feel you struggled during a week, do the week over again. The whole point is to enjoy yourself. Do whatever you enjoy. Don’t be sacred to try new skills, often after a few tries of a new trick you will gain confidence even though you may have not landed it yet."
    @State private var buttonText : String = "Next"
    
    // Timer
    @State var isTimerRunning = false
    @State private var startTime =  Date()
    @State var interval = TimeInterval()
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        ZStack{
            Color(red: 0.96, green: 0.96, blue: 0.96)
                .edgesIgnoringSafeArea(.all)
            NavigationLink(destination: PlanView(rootIsActive: self.$rootIsActive, width: width, height: height).environmentObject(self.planViewModel), isActive: self.$planIsActive) {
                Text("")
              }.hidden()
            if(introSlide <= 2){ // Shows the slide show.
                Ellipse()
                    .fill(Color(red: 0.28, green: 0.32, blue: 0.37))
                    .frame(width: height * 0.6, height: height * 0.7, alignment: .topLeading)
                    .offset(x: -height * 0.15, y: -height * 0.125)
                Image(image)
                    .resizable()
                    .frame(width: width, height: height * 0.4, alignment: .bottom)
                    .offset(y: height * 0.225)
                VStack{
                    switch(introSlide){
                    case 0:
                        Text("What's the plan?")
                            .font(.system(size: width * 0.055, weight: .bold, design: .monospaced))
                            .foregroundColor(Color(red: 0.96, green: 0.96, blue: 0.96))
                            .padding(.top, height * 0.1)
                            .padding(.bottom, height * 0.025)
                        Text(description1)
                            .font(.system(size: width * 0.04, weight: .bold, design: .default))
                            .foregroundColor(Color(red: 0.96, green: 0.96, blue: 0.96))
                            .multilineTextAlignment(.center)
                    case 1:
                        Text("Why?")
                            .font(.system(size: width * 0.055, weight: .bold, design: .monospaced))
                            .foregroundColor(Color(red: 0.96, green: 0.96, blue: 0.96))
                            .padding(.top, height * 0.1)
                            .padding(.bottom, height * 0.025)
                        Text(description2)
                            .font(.system(size: width * 0.04, weight: .bold, design: .default))
                            .foregroundColor(Color(red: 0.96, green: 0.96, blue: 0.96))
                            .multilineTextAlignment(.center)
                    case 2:
                        Text("How to?")
                            .font(.system(size: width * 0.055, weight: .bold, design: .monospaced))
                            .foregroundColor(Color(red: 0.96, green: 0.96, blue: 0.96))
                            .padding(.top, height * 0.1)
                            .padding(.bottom, height * 0.025)
                        Text(description3)
                            .font(.system(size: width * 0.04, weight: .bold, design: .default))
                            .foregroundColor(Color(red: 0.96, green: 0.96, blue: 0.96))
                            .multilineTextAlignment(.center)
                    default:
                        Text("END")
                    }
                    Spacer()
                        Button(action: {
                            withAnimation(.easeIn(duration: 1)){
                                if(introSlide == 2){
                                    if(Auth.auth().currentUser != nil){
                                        introSlide += 1
                                    }else{
                                        showingLogIn = true
                                    }
                                }else{
                                    introSlide += 1
                                }
                            }
                        }){
                            ZStack{
                                Rectangle()
                                    .fill(Color(red: 0.95, green: 0.32, blue: 0.34))
                                    .frame(width: width * 0.25, height: height * 0.06, alignment: .center)
                                    .cornerRadius(10)
                                    .shadow(color: Color(red: 66/255, green: 70/255, blue: 84/255, opacity: 0.5), radius: 3, x: 10, y: 10)
                                Text(introSlide == 2 ? "Begin" : "Next")
                                    .font(.system(size: width * 0.07, weight: .bold, design: .monospaced))
                                    .foregroundColor(Color(red: 0.13, green: 0.15, blue: 0.22))
                            }
                            
                        }
                        .sheet(isPresented: $showingLogIn,
                                content: {
                                    //LogInView()
                                })
                        .padding(.bottom, height * 0.05)
                }
                .frame(width: height * 0.3, height: height * 0.5, alignment: .topLeading)
                .offset(x: -height * 0.07, y: -height * 0.175)
            }else{
                if(Auth.auth().currentUser != nil){
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
                            // Show loading motion
                            LoadingView()
                                .onAppear(perform: {
                                    // Here the plan creation happens
                                    planViewModel.addPlanToDB(plan: planViewModel.createPlanObject(data: questionAnswers)){ res in
                                        if res {
                                            planViewModel.setData()
                                            currentUserViewModel.startPlan()
                                            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                                withAnimation {
                                                    planViewModel.fetchData()
                                                    planViewModel.fetchDataTasks()
                                                    self.rootIsActive = true
                                                }
                                            }
                                        }else{
                                            print("error")
                                            //Display alert to restart
                                        }
                                    }
                                })
                        }
                    }
                }else{
                    Text("NOT LOGGED IN").onAppear(perform: {introSlide -= 1})
                }
            }
        }
    }
}
