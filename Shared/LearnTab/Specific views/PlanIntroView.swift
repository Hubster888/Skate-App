//
//  PlanIntroView.swift
//  Skate App (iOS)
//
//  Created by Hubert Rzeminski on 25/01/2021.
//

import SwiftUI
import Firebase

struct PlanIntroView: View {
    
    @Binding var rootIsActive : Bool
    @State var planIsActive : Bool = false
    
    @State var showingLogIn = false
    
    @State private var introSlide : Int = 0
    @State private var questionNum : Int = 0
    @State private var questionAnswers = [String]()
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
                        case 0:
                            Text("How many days a week are you going to skate?")
                            Button(action: {
                                questionAnswers.append("1")
                                withAnimation{
                                    questionNum += 1
                                }

                            }){
                                Text("1 Day")
                            }
                            Button(action: {
                                questionAnswers.append("23")
                                withAnimation{
                                    questionNum += 1
                                }
                            }){
                                Text("2-3 Days")
                            }
                            Button(action: {
                                questionAnswers.append("45")
                                withAnimation{
                                    questionNum += 1
                                }
                            }){
                                Text("4-5 Days")
                            }
                            Button(action: {
                                questionAnswers.append("67")
                                withAnimation{
                                    questionNum += 1
                                }
                            }){
                                Text("6-7 Days")
                            }
                        case 1:
                            Text("How many hours a day are you going to skate?")
                            Button(action: {
                                questionAnswers.append("1")
                                withAnimation{
                                    questionNum += 1
                                }
                            }){
                                Text("1 Hour")
                            }
                            Button(action: {
                                questionAnswers.append("23")
                                withAnimation{
                                    questionNum += 1
                                }
                            }){
                                Text("2-3 Hours")
                            }
                            Button(action: {
                                questionAnswers.append("4")
                                withAnimation{
                                    questionNum += 1
                                }
                            }){
                                Text("4+ Hours")
                            }
                        case 2:
                            Text("How confident are you on a skateboard?")
                            Button(action: {
                                questionAnswers.append("1")
                                withAnimation{
                                    questionNum += 1
                                }
                            }){
                                Text("First time on one. ")
                            }
                            Button(action: {
                                questionAnswers.append("2")
                                withAnimation{
                                    questionNum += 1
                                }
                            }){
                                Text("I can ride comfortably ")
                            }
                            Button(action: {
                                questionAnswers.append("3")
                                withAnimation{
                                    questionNum += 1
                                }
                            }){
                                Text("I try some tricks ")
                            }
                            Button(action: {
                                questionAnswers.append("4")
                                withAnimation{
                                    questionNum += 1
                                }
                            }){
                                Text("I was born on a board ")
                            }
                        case 3:
                            Text("Pick a trick that you want to learn first:")
                            Button(action: {
                                questionAnswers.append("1")
                                withAnimation{
                                    questionNum += 1
                                }
                            }){
                                Text("Pop Shove It")
                            }
                            Text("OR")
                            Button(action: {
                                questionAnswers.append("2")
                                withAnimation{
                                    questionNum += 1
                                }
                            }){
                                Text("Kick Flip")
                            }
                        case 4:
                            Text("Pick a trick that you want to learn first:")
                            Button(action: {
                                questionAnswers.append("1")
                                withAnimation{
                                    questionNum += 1
                                }
                            }){
                                Text("Casper Flip")
                            }
                            Text("OR")
                            Button(action: {
                                questionAnswers.append("2")
                                withAnimation{
                                    questionNum += 1
                                }
                            }){
                                Text("Heel Flip")
                            }
                        case 5:
                            Text("Pick a trick that you want to learn first:")
                            Button(action: {
                                questionAnswers.append("1")
                                withAnimation{
                                    questionNum += 1
                                }
                            }){
                                Text("Power Slide")
                            }
                            Text("OR")
                            Button(action: {
                                questionAnswers.append("2")
                                withAnimation{
                                    questionNum += 1
                                }
                            }){
                                Text("Manual")
                            }
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
                                            /*UpdatePlanDB().getNewPlanId(){result in
                                                switch(result){
                                                case .success(let res):
                                                    print(res , "---------------------------")
                                                case .failure(let err):
                                                    print(err , "---------------------------")
                                                }
                                            }*/
                                            /*UpdatePlanDB().checkIdDoesNotExist(planId: 3, tableName: "UserPlans"){
                                                result in
                                                switch(result){
                                                case .success(let res):
                                                    if(res){
                                                        print("Not there")
                                                    }else {print("Exists")}
                                                case .failure(let err):
                                                    print(err)
                                                }
                                            }*/
                                            
                                            let newUpdate = UpdatePlanDB()
                                            newUpdate.getNewPlanId(){result in
                                                switch(result){
                                                case .success(let res):
                                                    newUpdate.addPlan(planId: res){ result2 in
                                                        switch(result2){
                                                        case .success(let res2):
                                                            print(String(describing: res2))
                                                        case .failure(let err2):
                                                            print(err2)
                                                        }
                                                    }
                                                    
                                                    newUpdate.addToUserPlans(planId: res){ result2 in
                                                        switch(result2){
                                                        case .success(let res2):
                                                            print(String(describing: res2))
                                                        case .failure(let err2):
                                                            print(err2)
                                                        }
                                                    }
                                                case .failure(let err):
                                                    print(err , "---------------------------")
                                                }
                                                
                                                
                                            }
                                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                                                withAnimation {
                                                    //PlanView()
                                                    //self.rootIsActive = false
                                                    self.planIsActive = true
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
                            // Update the DB with the data
                        // get lowest plan id if id > 2 then minus 1 and use that as new id
                        //  else get highest id of plan and add 1
                            
                        // Check no id of plan exist like that
                        
                        // add to UsersPlans currentUser.uid and new plan id
                        
                        
                        // using this plan id add a new plan
                            // Show the plan
                        }
                    }
                }else{
                    Text("NOT LOGGED IN").onAppear(perform: {introSlide -= 1})
                }
            }
        }
    }
}

// For root: if just done then launch planView (passed from intro view)
