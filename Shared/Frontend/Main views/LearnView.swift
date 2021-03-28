//
//  LearnView.swift
//  Skate App (iOS)
//
//  Created by Hubert Rzeminski on 09/12/2020.
//

import SwiftUI
import Firebase
import FirebaseFirestoreSwift

struct LearnView: View {
    
    //MARK: Variable declerations
    // Navigation variables
    @State private var tricksIsActive = false
    @State private var gamesIsActive = false
    @State private var planIsActive = false
    @State private var planIntroIsActive = false
    
    // Related data variables
    @ObservedObject var planViewModel = PlanViewModel()
    @EnvironmentObject var currentUserViewModel : CurrentUserViewModel
    
    // View variables
    var barOffset : CGFloat {
        return width * 0.25
    }
    var titleFontSize : CGFloat {
        return width * 0.1
    }
    var subTextFontSize : CGFloat {
        return width * 0.03
    }
    var subTextFrameWidth : CGFloat {
        return width * 0.4
    }
    var bottomPadding : CGFloat {
        return height * 0.075
    }
    let width: CGFloat = UIScreen.main.bounds.width
    let height: CGFloat = UIScreen.main.bounds.height
    let backgroundColor : Color = Color(red: 0.96, green: 0.96, blue: 0.96) // White
    let defaultColor : Color = Color(red: 0.13, green: 0.15, blue: 0.22) // Black
    let subTextColor : Color = Color(red: 0.28, green: 0.32, blue: 0.37) // Gray
    let barWidth : CGFloat = 30
    
    // Changes the apperance of navigation bar and tab bar
    init(){
        let navBarAppearance = UINavigationBar.appearance()
        navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor(red: 0.96, green: 0.96, blue: 0.96, alpha: 1.0)]
        navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor(red: 0.96, green: 0.96, blue: 0.96, alpha: 1.0)]
        navBarAppearance.barTintColor = UIColor(red: 0.13, green: 0.15, blue: 0.22, alpha: 1.0)
        
        UITabBar.appearance().backgroundColor = UIColor(red: 0.13, green: 0.15, blue: 0.22, alpha: 1.0)
        
        UITabBar.appearance().barTintColor = UIColor(red: 0.13, green: 0.15, blue: 0.22, alpha: 1.0)
    }
    
    //MARK: Body
    var body: some View {
        NavigationView {
            ZStack{
                backgroundColor.edgesIgnoringSafeArea(.all)
                Rectangle()
                    .fill(defaultColor)
                    .frame(width: barWidth, height: height)
                    .offset(x: -barOffset)
                VStack{
                    if(currentUserViewModel.currentUser != nil && currentUserViewModel.currentUser!.planStarted){
                        NavigationLink(destination: PlanView(rootIsActive: self.$planIsActive)
                                        .environmentObject(self.planViewModel),
                                       isActive: $planIsActive) {
                            VStack{
                                Text("PLAN")
                                    .font(.system(size: titleFontSize, weight: .bold, design: .monospaced))
                                    .foregroundColor(defaultColor)
                                                
                                Text("Personalise your learning!")
                                    .font(.system(size: subTextFontSize, weight: .bold, design: .default))
                                    .foregroundColor(subTextColor)
                                    .frame(width: subTextFrameWidth, alignment: .center)
                                    .multilineTextAlignment(.center)
                                    
                            }.frame(alignment: .trailing)
                        }.buttonStyle(LearnButtonEffectButtonStyle(image: Image("learnPlanButton"), action: { self.planIsActive.toggle()}))
                        .onTapGesture {
                            self.planViewModel.fetchData()
                            self.planViewModel.fetchDataTasks()
                        }
                    }else{
                        NavigationLink(destination: PlanIntroView(rootIsActive: self.$planIsActive)
                                        .environmentObject(self.planViewModel)
                                        .environmentObject(self.currentUserViewModel),
                                       isActive: $planIntroIsActive) {
                            VStack{
                                Text("PLAN")
                                    .font(.system(size: titleFontSize, weight: .bold, design: .monospaced))
                                    .foregroundColor(defaultColor)
                                                
                                Text("Personalise your learning!")
                                    .font(.system(size: subTextFontSize, weight: .bold, design: .default))
                                    .foregroundColor(subTextColor)
                                    .frame(width: subTextFrameWidth, alignment: .center)
                                    .multilineTextAlignment(.center)
                                    
                            }.frame(alignment: .trailing)
                        }
                        .isDetailLink(false)
                        .buttonStyle(LearnButtonEffectButtonStyle(image: Image("learnPlanButton"), action: {self.planIntroIsActive.toggle()}))
                        .onTapGesture {
                            self.planViewModel.fetchData()
                            self.planViewModel.fetchDataTasks()
                        }
                    }
                            
                    NavigationLink(destination: TrickSelectView(), isActive: $tricksIsActive) {
                        VStack{
                            Text("TRICKS")
                                .font(.system(size: titleFontSize, weight: .bold, design: .monospaced))
                                .foregroundColor(defaultColor)
                                                
                            Text("Find the tricks here!")
                                .font(.system(size: subTextFontSize, weight: .bold, design: .default))
                                .foregroundColor(subTextColor)
                                .frame(width: subTextFrameWidth, alignment: .center)
                                .multilineTextAlignment(.center)
                            
                        }
                        .frame(alignment: .trailing)
                    }.buttonStyle(LearnButtonEffectButtonStyle(image: Image("learnTricksButton"), action: { self.tricksIsActive.toggle()}))
                    
                            
                    NavigationLink(destination: GameSelectView(), isActive: $gamesIsActive) {
                        VStack{
                            Text("GAMES")
                                .font(.system(size: titleFontSize, weight: .bold, design: .monospaced))
                                .foregroundColor(defaultColor)
                                                
                            Text("Play skating games with friends or solo!")
                                .font(.system(size: subTextFontSize, weight: .bold, design: .default))
                                .foregroundColor(subTextColor)
                                .frame(width: subTextFrameWidth, alignment: .center)
                                .multilineTextAlignment(.center)
                            
                        }.frame(alignment: .trailing)
                    }
                    .buttonStyle(LearnButtonEffectButtonStyle(image: Image("learnGamesButton"), action: { self.gamesIsActive.toggle()}))
                    .padding(.bottom, -bottomPadding)
                }.frame(width: width, height: height, alignment: .center)
            }
            .navigationBarTitle(Text("Learn"), displayMode: .inline)
            .navigationBarItems( trailing: NavigationLink(destination: settingsView()) {
                Image(systemName: "gear")
                    .foregroundColor(backgroundColor)
            })
            .onAppear(perform: {
                if(Auth.auth().currentUser != nil){
                    self.planViewModel.fetchData()
                    self.planViewModel.fetchDataTasks()
                    if(currentUserViewModel.currentUser!.planStarted){
                        self.planViewModel.fetchDataTasks()
                    }
                }
                UINavigationBar.appearance().barTintColor = UIColor(red: 0.13, green: 0.15, blue: 0.22, alpha: 1.0)
            })
        }
    }
}
