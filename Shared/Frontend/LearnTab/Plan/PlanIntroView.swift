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
    
    @Binding var rootIsActive : Bool
    @State var planIsActive : Bool = false
    
    @State var showingLogIn = false
    
    //Question Answers
    @State var questionAnswers : Dictionary<Int,Int> = [1:0,2:0,3:0,4:0,5:0,6:0]
    
    @State private var introSlide : Int = 0
    @State private var questionNum : Int = 1
    @State private var image : String = "skatePicModed"
    @State private var title : String = "Title"
    @State private var description : String = "This is one sentence for a sample description of what is going on."
    @State private var buttonText : String = "Next"
    
    @State var isTimerRunning = false
    @State private var startTime =  Date()
    @State var interval = TimeInterval()
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @State private var isLoading = false
    
    var width: CGFloat {
        return UIScreen.main.bounds.width
    }
    
    var height: CGFloat {
        return UIScreen.main.bounds.height
    }
    
    var body: some View {
        ZStack{
            NavigationLink(destination: PlanView(rootIsActive: self.$rootIsActive), isActive: self.$planIsActive) {
                Text("")
              }.hidden()
            Color(red: 0.96, green: 0.96, blue: 0.96).edgesIgnoringSafeArea(.all)
            if(introSlide <= 2){
                Ellipse()
                    .fill(Color(red: 0.28, green: 0.32, blue: 0.37))
                    .frame(width: height * 0.55, height: height * 0.7, alignment: .topLeading)
                    .offset(x: -height * 0.15, y: -height * 0.125)
                Image(image)
                    .resizable()
                    .frame(width: width, height: height * 0.4, alignment: .bottom)
                    .offset(y: height * 0.225)
                VStack{
                    switch(introSlide){
                    case 0:
                        Text("Title 1")
                            .font(.system(size: width * 0.1, weight: .bold, design: .monospaced))
                            .foregroundColor(Color(red: 0.96, green: 0.96, blue: 0.96))
                            .padding(.bottom, height * 0.05)
                            .padding(.top, height * 0.1)
                        Text(description)
                            .font(.system(size: width * 0.05, weight: .bold, design: .default))
                            .foregroundColor(Color(red: 0.96, green: 0.96, blue: 0.96))
                            .multilineTextAlignment(.center)
                    case 1:
                        Text("Title 2")
                            .font(.system(size: width * 0.1, weight: .bold, design: .monospaced))
                            .foregroundColor(Color(red: 0.96, green: 0.96, blue: 0.96))
                            .padding(.bottom, height * 0.05)
                            .padding(.top, height * 0.1)
                        Text(description)
                            .font(.system(size: width * 0.05, weight: .bold, design: .default))
                            .foregroundColor(Color(red: 0.96, green: 0.96, blue: 0.96))
                            .multilineTextAlignment(.center)
                    default:
                        Text("END")
                            .font(.system(size: width * 0.1, weight: .bold, design: .monospaced))
                            .foregroundColor(Color(red: 0.96, green: 0.96, blue: 0.96))
                            .padding(.bottom, height * 0.05)
                            .padding(.top, height * 0.1)
                        Text(description)
                            .font(.system(size: width * 0.05, weight: .bold, design: .default))
                            .foregroundColor(Color(red: 0.96, green: 0.96, blue: 0.96))
                            .multilineTextAlignment(.center)
                    }
                    
                    Spacer()
                    if(introSlide == 2){
                        Button(action: {
                            withAnimation(.easeIn(duration: 1)){
                                if(Auth.auth().currentUser != nil){
                                    introSlide += 1
                                }else{
                                    showingLogIn = true
                                }
                            }
                        }){
                            ZStack{
                                Rectangle()
                                    .fill(Color(red: 0.95, green: 0.32, blue: 0.34))
                                    .frame(width: width * 0.35, height: height * 0.08, alignment: .center)
                                    .cornerRadius(10)
                                Text("Begin")
                                    .font(.system(size: width * 0.09, weight: .bold, design: .default))
                                    .foregroundColor(Color(red: 0.13, green: 0.15, blue: 0.22))
                            }
                            
                        }
                        .sheet(isPresented: $showingLogIn,
                                content: {
                                    LogInView(showingDetail: self.$showingLogIn)
                                })
                        .padding(.bottom, height * 0.05)
                    }else{
                        Button(action: {
                            withAnimation(.easeIn(duration: 1)){
                                introSlide += 1
                            }
                        }){
                            ZStack{
                                Rectangle()
                                    .fill(Color(red: 0.95, green: 0.32, blue: 0.34))
                                    .frame(width: width * 0.35, height: height * 0.08, alignment: .center)
                                    .cornerRadius(10)
                                Text("Next")
                                    .font(.system(size: width * 0.09, weight: .bold, design: .default))
                                    .foregroundColor(Color(red: 0.13, green: 0.15, blue: 0.22))
                            }
                            
                        }.padding(.bottom, height * 0.05)
                    }
                    
                }
                .frame(width: height * 0.3, height: height * 0.5, alignment: .topLeading)
                .offset(x: -height * 0.07, y: -height * 0.175)
            }else{
                if(Auth.auth().currentUser != nil){
                    VStack{
                        switch(questionNum){
                        case 1:
                            QuestionView(questionResults: self.$questionAnswers, questionNum: self.$questionNum, question: "How many days a week are you going to skate?", answerList: ["1 Day","2-3 Days","4-5 Days","6-7 Days"], twoChoice: false)
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
                            VStack{
                                Spacer()
                                ZStack{
                                    Text("Getting plan ready!")
                                        .font(.system(size: 20, design: .rounded))
                                        .bold()
                                        .offset(x: 0, y: -25)
                                     
                                    RoundedRectangle(cornerRadius: 3)
                                        .stroke(Color(.systemGray5), lineWidth: 3)
                                        .frame(width: 250, height: 3)
                                     
                                    RoundedRectangle(cornerRadius: 3)
                                        .stroke(Color(red: 0.95, green: 0.32, blue: 0.34), lineWidth: 3)
                                        .frame(width: 30, height: 3)
                                        .offset(x: isLoading ? 110 : -110, y: 0)
                                        .animation(Animation.linear(duration: 1).repeatForever(autoreverses: false))
                                        .onAppear(perform: {
                                            self.isLoading = true
                                            PlanViewModel().addPlanToDB(plan: PlanViewModel().createPlanObject(data: questionAnswers)){ res in
                                                if res {
                                                    CurrentUserViewModel().startPlan()
                                                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                                                        withAnimation {
                                                            self.planIsActive = true
                                                        }
                                                    }
                                                }else{
                                                    print("error")
                                                    //Display alert to restart
                                                }
                                            }
                                        })
                                }
                                Spacer()
                                Image("skatePicModed")
                                    .resizable()
                                    .frame(width: width, height: height * 0.4, alignment: .bottom)
                                    .offset(y: height * 0.05)
                            }
                        }
                    }
                }else{
                    Text("NOT LOGGED IN").onAppear(perform: {introSlide -= 1})
                }
            }
        }
    }
}
