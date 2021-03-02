//
//  PlanIntroView.swift
//  Skate App (iOS)
//
//  Created by Hubert Rzeminski on 25/01/2021.
//

import SwiftUI
import Firebase

struct PlanIntroView: View {
    
    //MARK: Variable Declerations
    // Navigation variables
    @Binding var rootIsActive : Bool
    @State var planIsActive : Bool = false
    @State var showingLogIn = false
    
    //Plan data variables
    @EnvironmentObject var planViewModel : PlanViewModel
    @EnvironmentObject var currentUserViewModel : CurrentUserViewModel
    @State private var introSlide : Int = 0
    @State private var questionNum : Int = 1
    
    // Questions and titles
    @State private var image : String = "skatePicModed"
    @State private var buttonText : String = "Next"
    let descriptionArray : [String] = ["This here is your personalised skating plan to improve those skills in your own time. Based on a few answers you will provide; the plan plops you into the correct week and adjusts the time spent skating to your free time.","Don’t know what you're doing? The plan lets you improve on your own terms and guides you through the stages of becoming a “good” skater and enjoying yourself more. \"The plan only shows recommendations, you need to go at your own pace!\"","If you feel you struggled during a week, do the week over again. The whole point is to enjoy yourself. Do whatever you enjoy. Don’t be sacred to try new skills, often after a few tries of a new trick you will gain confidence even though you may have not landed it yet."]
    let titleArray : [String] = ["What's the plan?","Why?","How to?"]
    
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
            if(introSlide <= 2){ // Shows the slide show.
                Ellipse()
                    .fill(circleColor)
                    .frame(width: circleWidth, height: circleHeight, alignment: .topLeading)
                    .offset(x: -circleOffsets, y: -circleOffsets)
                Image(image)
                    .resizable()
                    .frame(width: width, height: imageHeight, alignment: .bottom)
                    .offset(y: imageHeight)
                
                //MARK: Title And Descriptions
                VStack{ //TODO: Make the text look better
                    switch(introSlide){
                    case 0:
                        Text(titleArray[introSlide])
                            .font(.system(size: titleFontSize, weight: .bold, design: .monospaced))
                            .foregroundColor(backgroundColor)
                            .padding(EdgeInsets(top: titleTopPadding, leading: 0, bottom: titleBottomPadding, trailing: 0))
                        Text(descriptionArray[introSlide])
                            .font(.system(size: descriptionFontSize, weight: .bold, design: .default))
                            .foregroundColor(backgroundColor)
                            .multilineTextAlignment(.center)
                    case 1:
                        Text(titleArray[introSlide])
                            .font(.system(size: titleFontSize, weight: .bold, design: .monospaced))
                            .foregroundColor(backgroundColor)
                            .padding(EdgeInsets(top: titleTopPadding, leading: 0, bottom: titleBottomPadding, trailing: 0))
                        Text(descriptionArray[introSlide])
                            .font(.system(size: descriptionFontSize, weight: .bold, design: .default))
                            .foregroundColor(backgroundColor)
                            .multilineTextAlignment(.center)
                    case 2:
                        Text(titleArray[introSlide])
                            .font(.system(size: titleFontSize, weight: .bold, design: .monospaced))
                            .foregroundColor(backgroundColor)
                            .padding(EdgeInsets(top: titleTopPadding, leading: 0, bottom: titleBottomPadding, trailing: 0))
                        Text(descriptionArray[introSlide])
                            .font(.system(size: descriptionFontSize, weight: .bold, design: .default))
                            .foregroundColor(backgroundColor)
                            .multilineTextAlignment(.center)
                    default:
                        Text("END") //TODO: Set a message to try creating plan again
                    }
                    Spacer()
                    
                    //MARK: Next Button
                    Button(action: {
                        withAnimation(.easeIn(duration: 1)){
                            //TODO: Make button look better
                            if(introSlide == 2){ // If on last slide, create plan or log in
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
                                .fill(tintColor)
                                .frame(width: width/4, height: buttonHeight, alignment: .center)
                                .cornerRadius(cornerRadius)
                                .shadow(color: circleColor.opacity(0.5), radius: shdowRadiuse, x: cornerRadius, y: cornerRadius)
                            Text(introSlide == 2 ? "Begin" : "Next")
                                .font(.system(size: titleFontSize, weight: .bold, design: .monospaced))
                                .foregroundColor(circleColor)
                        }
                    }
                    .padding(.bottom, buttonHeight)
                    .sheet(isPresented: $showingLogIn,
                            content: { //FIXME: Ask to login when creating plan
                                //LogInView()
                            })
                }
                .frame(width: imageHeight, height: circleWidth, alignment: .topLeading)
                .offset(x: -buttonHeight, y: -circleOffsets)
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
                            LoadingView()
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
                    Text("NOT LOGGED IN").onAppear(perform: {introSlide -= 1}) //TODO: Find better way to pass this message
                }
            }
        }
    }
}
